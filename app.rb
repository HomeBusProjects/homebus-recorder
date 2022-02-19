# coding: utf-8
require 'homebus'

require 'dotenv'
require 'mongoid'

require 'time'

class RecorderHomebusApp < Homebus::App
  DDCS = [
    'org.homebus.experimental.3dprinter',
    'org.homebus.experimental.3dprinter-completed-job',
    'org.pdxhackerspace.experimental.access',
    'org.homebus.experimental.network-active-hosts',
    'org.homebus.experimental.air-sensor',
    'org.homebus.experimental.air-quality-sensor',
    'org.homebus.experimental.alert',
    'org.homebus.experimental.aqi-pm25',
    'org.homebus.experimental.aqi-o3',
    'org.homebus.experimental.co-sensor',
    'org.homebus.experimental.co2-sensor',
    'org.homebus.experimental.ch4-sensor',
    'org.homebus.experimental.diagnostic',
    'org.homebus.experimental.h2co-sensor',
    'org.homebus.experimental.image',
    'org.homebus.experimental.license',
    'org.homebus.experimental.light-sensor',
    'org.homebus.experimental.location',
    'org.homebus.experimental.lunar-phase',
    'org.homebus.experimental.my-ip',
    'org.homebus.experimental.nh3-sensor',
    'org.homebus.experimental.no2-sensor',
    'org.homebus.experimental.noise-sensor',
    'org.homebus.experimental.network-bandwidth',
    'org.homebus.experimental.origin',
    'org.homebus.experimental.o2-sensor',
    'org.homebus.experimental.o3-sensor',
    'org.homebus.experimental.server-status',
    'org.homebus.experimental.soil-sensor',
    'org.homebus.experimental.solar-clock',
    'org.homebus.experimental.switch',
    'org.homebus.experimental.system',
    'org.homebus.experimental.temperature-sensor',
    'org.homebus.experimental.uv-light-sensor',
    'org.homebus.experimental.voc-sensor',
    'org.homebus.experimental.weather',
    'org.homebus.experimental.weather-forecast',
  ]

  def initialize(options)
    @options = options
    super
  end

  def setup!
    Dotenv.load('.env')

    @image_expiration_interval = 86400

    @client = Mongo::Client.new(ENV['MONGODB_URL'])
    @db = @client.database

    @device = Homebus::Device.new name: 'Homebus recorder',
                                  manufacturer: 'Homebus',
                                  model: 'Recorder',
                                  serial_number: ''

    _create_collections
  end

  def work!
    DDCS.each do |ddc|
      @device.provision.broker.subscribe!(ddc)
    end

    listen!
  end

  def receive!(msg)
    item = { metadata: {
               source: msg[:source]
             },
             timestamp: Time.at(msg[:timestamp]).to_datetime
           }

    if msg[:payload].class == Array
      item[:data] = msg[:payload]
    else
      item.merge! msg[:payload]
    end

    @db[msg[:ddc]].insert_one(item)
  end

  def _create_collections
    DDCS.each do |ddc|
      if ddc == 'org.experimental.homebus.image'
      Mongo::Collection.new(@db,
                            ddc,
                            {
                              time_series: {
                                timeField: "timestamp",
                                metaField: "metadata",
                                granularity: "minutes"
                              },
                              expireAfterSeconds: @image_expiration_interval
                            })

      else
        Mongo::Collection.new(@db,
                              ddc,
                              {
                                time_series: {
                                  timeField: "timestamp",
                                  metaField: "metadata",
                                  granularity: "minutes"
                                }
                              })
      end
    end
  end

  def name
    'Homebus recorder'
  end

  def consumes
    DDCS
  end

  def publishes
    []
  end

  def devices
    [ @device ]
  end
end
