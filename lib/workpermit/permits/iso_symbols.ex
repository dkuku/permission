defmodule Workpermit.IsoSymbols do
  def iso_code_meaning(code) do
    sign = %{
      E001: "Emergency exit (left hand)",
      E002: "Emergency exit (right hand)",
      E003: "First aid",
      E004: "Emergency telephone",
      E005: "Direction arrow (90° angle)",
      E006: "Direction arrow (45° angle)",
      E007: "Evacuation assembly point",
      E008: "Break to obtain access",
      E009: "Doctor",
      E010: "Automated external heart defibrillator",
      E011: "Eyewash station",
      E012: "Safety shower",
      E013: "Stretcher",
      E016: "Emergency window with escape ladder",
      E017: "Rescue window",
      E018: "Turn anticlockwise (counterclockwise) to open",
      E019: "Turn clockwise to open",
      F001: "Fire extinguisher",
      F002: "Fire hose reel",
      F003: "Fire ladder",
      F004: "Collection of firefighting equipment",
      F005: "Fire alarm call point",
      F006: "Fire emergency telephone",
      M001: "General mandatory action sign",
      M002: "Refer to instruction manual/booklet",
      M003: "Wear ear protection",
      M004: "Wear eye protection",
      M005: "Connect an earth terminal to the ground",
      M006: "Disconnect mains plug from electrical outlet",
      M007: "Opaque eye protection must be worn",
      M008: "Wear foot protection",
      M009: "Wear protective gloves",
      M010: "Wear protective clothing",
      M011: "Wash your hands",
      M012: "Use handrail",
      M013: "Wear a face shield",
      M014: "Wear head protection",
      M015: "Wear high visibility clothing",
      M016: "Wear a dust mask",
      M017: "Wear respiratory protection",
      M018: "Wear a safety harness",
      M019: "Wear a welding mask",
      M020: "Wear safety belts",
      M021: "Disconnect before carrying out maintenance or repair",
      M022: "Use barrier cream",
      M023: "Use footbridge",
      M024: "use this walkway",
      M025: "Protect infants eyes with opaque eye protection",
      M026: "Use protective apron",
      P001: "General prohibition sign",
      P002: "No smoking",
      P003: "No open flame",
      P004: "No thoroughfare",
      P005: "Not drinking water",
      P006: "No access for forklift trucks and industrial vehicles",
      P007: "No access for people with active implanted cardiac devices",
      P008: "No metallic articles or watches",
      P010: "Do not touch",
      P011: "Do not extinguish with water",
      P012: "No heavy load",
      P013: "No activated mobile phone",
      P014: "No access for people with metallic implants",
      P015: "No reaching in",
      P017: "No pushing",
      P018: "No sitting",
      P019: "No stepping on surface",
      P020: "Do not use lift in the event of fire",
      P021: "No dogs",
      P022: "No eating or drinking",
      P023: "Do not obstruct",
      P024: "Do not walk or stand here",
      P025: "Do not use this incomplete scaffold",
      P026: "Do not use this device in a bathtub, shower or water-filled reservoir",
      P027: "Do not use this lift for people",
      P028: "Do not wear gloves",
      P029: "No photography",
      P030: "Do not tie knots in rope",
      P031: "Do not alter the state of the switch",
      P032: "Do not use for face grinding",
      P033: "Do not use for wet grinding",
      P034: "Do not use with hand-held grinder",
      W001: "General warning sign",
      W002: "Explosive materials",
      W003: "Radioactive material or ionizing radiation",
      W004: "Laser beam",
      W005: "Non-ionizing radiation",
      W006: "Magnetic field",
      W007: "Floor-level obstacle",
      W008: "Drop or fall hazard",
      W009: "Biological hazard",
      W010: "Low temperature hazard",
      W011: "Slippery surface",
      W012: "Electricity hazard",
      W013: "Guard dog",
      W014: "Forklift truck and other industrial vehicles",
      W015: "Overhead or suspended load",
      W016: "Toxic material",
      W017: "Hot surface",
      W018: "Automatic start-up",
      W019: "Crushing by moving parts",
      W020: "Overhead obstacle",
      W021: "Flammable material",
      W022: "Sharp element",
      W023: "Corrosive substance",
      W024: "Crushing of hands",
      W025: "Counter-rotating rollers",
      W026: "Battery charging",
      W027: "Optical radiation",
      W028: "Oxidizing substance",
      W029: "Pressurized cylinder",
      W035: "Falling Parts",
      W039: "Falling Ice Spikes",
      A001: "Confined Space"
    }

    sign[code] || "No sign with that description"
  end

  def to_iso_code_mapping() do
    %{
      emergency_exit_left: :E001,
      emergency_exit_right: :E002,
      first_aid: :E003,
      emergency_telephone: :E004,
      direction_arrow_90: :E005,
      direction_arrow_45: :E006,
      evacuation_assembly_point: :E007,
      break_to_obtain_access: :E008,
      doctor: :E009,
      automated_external_heart_defibrillator: :E010,
      eyewash_station: :E011,
      safety_shower: :E012,
      stretcher: :E013,
      emergency_window_with_escape_ladder: :E016,
      rescue_window: :E017,
      turn_anticlockwise_to_open: :E018,
      turn_clockwise_to_open: :E019,
      fire_extinguisher: :F001,
      fire_hose_reel: :F002,
      fire_ladder: :F003,
      collection_of_firefighting_equipment: :F004,
      fire_alarm_call_point: :F005,
      fire_emergency_telephone: :F006,
      general_action_sign: :M001,
      instruction_manual: :M002,
      ear_protection: :M003,
      eye_protection: :M004,
      earth_terminal: :M005,
      disconnect_mains: :M006,
      opaque_eye_protection: :M007,
      foot_protection: :M008,
      protective_gloves: :M009,
      protective_clothing: :M010,
      wash_hands: :M011,
      use_handrail: :M012,
      face_shield: :M013,
      head_protection: :M014,
      high_visibility_clothing: :M015,
      dust_mask: :M016,
      respiratory_protection: :M017,
      safety_harness: :M018,
      welding_mask: :M019,
      safety_belts: :M020,
      disconnect_before_repair: :M021,
      use_barrier_cream: :M022,
      use_footbridge: :M023,
      use_walkway: :M024,
      protect_infants_eyes: :M025,
      use_protective_apron: :M026,
      general_prohibition_sign: :P001,
      no_smoking: :P002,
      no_open_flame: :P003,
      no_thoroughfare: :P004,
      not_drinking_water: :P005,
      no_access_for_forklift_trucks_and_industrial_vehicles: :P006,
      no_access_for_people_with_active_implanted_cardiac_devices: :P007,
      no_metallic_articles_or_watches: :P008,
      do_not_touch: :P010,
      do_not_extinguish_with_water: :P011,
      no_heavy_load: :P012,
      no_activated_mobile_phone: :P013,
      no_access_for_people_with_metallic_implants: :P014,
      no_reaching_in: :P015,
      no_pushing: :P017,
      no_sitting: :P018,
      no_stepping_on_surface: :P019,
      do_not_use_lift_in_the_event_of_fire: :P020,
      no_dogs: :P021,
      no_eating_or_drinking: :P022,
      do_not_obstruct: :P023,
      do_not_walk_or_stand_here: :P024,
      do_not_use_this_incomplete_scaffold: :P025,
      do_not_use_this_device_in_a_bathtub_shower_or_water_filled_reservoir: :P026,
      do_not_use_this_lift_for_people: :P027,
      do_not_wear_gloves: :P028,
      no_photography: :P029,
      do_not_tie_knots_in_rope: :P030,
      do_not_alter_the_state_of_the_switch: :P031,
      do_not_use_for_face_grinding: :P032,
      do_not_use_for_wet_grinding: :P033,
      do_not_use_with_hand_held_grinder: :P034,
      general_warning_sign: :W001,
      explosive_materials: :W002,
      radioactive_material_or_ionizing_radiation: :W003,
      laser_beam: :W004,
      non_ionizing_radiation: :W005,
      magnetic_field: :W006,
      floor_level_obstacle: :W007,
      drop_or_fall_hazard: :W008,
      biological_hazard: :W009,
      low_temperature_hazard: :W010,
      slippery_surface: :W011,
      electricity_hazard: :W012,
      guard_dog: :W013,
      forklift_truck_and_other_industrial_vehicles: :W014,
      overhead_or_suspended_load: :W015,
      toxic_material: :W016,
      hot_surface: :W017,
      automatic_start_up: :W018,
      crushing_by_moving_parts: :W019,
      overhead_obstacle: :W020,
      flammable_material: :W021,
      sharp_element: :W022,
      corrosive_substance: :W023,
      crushing_of_hands: :W024,
      counter_rotating_rollers: :W025,
      battery_charging: :W026,
      optical_radiation: :W027,
      oxidizing_substance: :W028,
      pressurized_cylinder: :W029,
      falling_parts: :W035,
      falling_ice_spikes: :W039,
      confined_space: :A001
    }
  end

  def to_iso_code(protective_eq) when is_atom(protective_eq) do
    # input :falling_parts =>  :W039
    to_iso_code_mapping()[protective_eq] || :A999
  end

  def to_iso_code(protective_eq), do: protective_eq |> String.to_existing_atom() |> to_iso_code

  def to_image_path(protective_eq, path \\ "/iso/") do
    # input :falling_parts => IS0_111.svg
    path <> "ISO_7010_#{to_iso_code(protective_eq)}.svg"
  end

  def to_sign_meaning(protective_eq) when is_atom(protective_eq) do
    # input :falling_parts => "Faling Parts"
    protective_eq |> to_iso_code |> iso_code_meaning
  end

  def to_sign_meaning(protective_eq),
    do: protective_eq |> String.to_existing_atom() |> to_sign_meaning
end
