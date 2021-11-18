require 'homebus'

class RecorderHomebusAppOptions < Homebus::Options
  def app_options(op)
  end

  def banner
    'Homebus Recorder'
  end

  def version
    '0.0.1'
  end

  def name
    'homebus-recorder'
  end
end
