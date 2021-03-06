defmodule Parser do

  # ELEMENT IoT Parser for Lobaro wMBus bridge
  # made for vif-filtered data provided from devices
  # implemented: Volume measurements (VIF Code E0010nnn) and undefined DIF Codes (assuming Integer values)

    use Platform.Parsing.Behaviour

    def parse(<<_status::8, _dev_no::little-32, _dif_field::8, vif_field::8, value::binary>>, %{meta: %{frame_port: 9}}) do
        << _unit::5, factor::3>> = <<vif_field>>
        n = :math.pow(10,factor-3)
        %{
          unit: "m3",
          value: value*n
        }
    end
end
