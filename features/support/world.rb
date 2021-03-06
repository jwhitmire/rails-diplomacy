module DiplomacyWorld
  def adjudicator
    if @adjudicator.nil?
      mapreader = Diplomacy::MapReader.new
      mapreader.read_map_file(Rails.root+'lib/graph/maps.yaml')
      @adjudicator = Diplomacy::Adjudicator.new(mapreader.maps['Standard'])
    end
    @adjudicator
  end
  
  def gamestate
    @gamestate ||= Diplomacy::GameState.new
  end
  
  def orders
    @orders ||= []
  end
  
  def unit_type(abbrv)
    return Diplomacy::Unit::ARMY if abbrv == "A"
    return Diplomacy::Unit::FLEET if abbrv == "F"
  end
  
  def parse_units(unitblob)
    units_by_power = unitblob.split
    units_by_power.each do |string|
      power,units = string.split(":")
      unit_array = units.scan(/[AF]\w{3}/)
      
      unit_array.each do |unit|
        type,area = parse_single_unit(unit)
        gamestate[area.to_sym] = Diplomacy::AreaState.new(nil,Diplomacy::Unit.new(power,unit_type(type)))
      end
    end
  end
  
  def parse_single_unit(unitblob)
    m = /([AF])(\w{3})/.match(unitblob)
    return m[1],m[2]
  end
  
  def parse_orders(orderblob)
    order_list = orderblob.split(',')
    
    order_list.each do |order_text|
      orders << parse_single_order(order_text)
    end
  end
  
  def parse_single_order(orderblob)
    # try to parse it as a move
    /^[AF](?'unit_area'\w{3})(?'unit_area_coast'\(.+?\))?-(?'dst'\w{3})(?'dst_coast'[^-]+)?$/ =~ orderblob
    if not unit_area.nil?
      unit = gamestate[unit_area.to_sym].unit unless unit_area.nil?
      move = Diplomacy::Move.new(unit, unit_area.to_sym, dst.to_sym)
      move.unit_area_coast = unit_area_coast if not unit_area_coast.nil?
      move.dst_coast = dst_coast if not dst_coast.nil?
      return move
    end
    
    # try to parse it as a hold
    /^[AF](?'unit_area'\w{3})H$/ =~ orderblob
    if not unit_area.nil?
      unit = gamestate[unit_area.to_sym].unit unless unit_area.nil?
      return Diplomacy::Hold.new(unit, unit_area.to_sym)
    end
    
    # try to parse it as a support
    /^[AF](?'unit_area'\w{3})(?'unit_area_coast'\(.+?\))?S[AF](?'src'\w{3})(?'src_coast'\(.+?\))?-(?'dst'\w{3})(?'dst_coast'[^-]+)?$/ =~ orderblob
    if not unit_area.nil?
      unit = gamestate[unit_area.to_sym].unit unless unit_area.nil?
      support = Diplomacy::Support.new(unit, unit_area.to_sym, src.to_sym, dst.to_sym)
      support.unit_area_coast = unit_area_coast if not unit_area_coast.nil?
      support.src_coast = src_coast if not src_coast.nil?
      support.dst_coast = dst_coast if not dst_coast.nil?
      return support
    end
    
    # try to parse it as a support hold
    /^[AF](?'unit_area'\w{3})S[AF](?'dst'\w{3})$/ =~ orderblob
    if not unit_area.nil?
      unit = gamestate[unit_area.to_sym].unit unless unit_area.nil?
      return Diplomacy::SupportHold.new(unit, unit_area.to_sym, dst.to_sym)
    end
    
    # try to parse it as a convoy
    /^[AF](?'unit_area'\w{3})C[AF](?'src'\w{3})-(?'dst'\w{3})$/ =~ orderblob
    if not unit_area.nil?
      unit = gamestate[unit_area.to_sym].unit unless unit_area.nil?
      return Diplomacy::Convoy.new(unit, unit_area.to_sym, src.to_sym, dst.to_sym)
    end
  end
  
  def status_to_s(status)
    case status
    when Diplomacy::SUCCESS
      return 'S'
    when Diplomacy::FAILURE
      return 'F'
    when Diplomacy::INVALID
      return 'I'
    end
  end
end

World(DiplomacyWorld)
