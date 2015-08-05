if SETTINGS[:noenv_enable]
  before = 'model_name'
  Deface::Override.new(
    :virtual_path   => 'hosts/_form',
    :name           => 'hosts_noenv',
    :insert_before  => "div##{before}",
    :partial        => 'hosts/noenv_field',
  )
end
