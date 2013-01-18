CanTango.config do |config|
  config.debug.set :on
  config.permits.disable :account, :special, :role_group
  config.engines.all :on
  #config.engine(:permission).set :off
  #config.engine(:cache).set :off
  config.guest.user Proc.new { Guest.instance }
end
