defmodule JumpUp.WakeUpMegaboomTest do
  use ExUnit.Case

  import Mock

  describe ".run" do
    test 'when succeeds' do
      with_mock System,
        cmd: fn _command, _options -> {"Characteristic value was written successfully\n", 0} end do
        JumpUp.WakeUpMegaboom.run()

        assert_called(
          System.cmd("gatttool", [
            "-b",
            "00:11:22:33:44:55",
            "--char-write-req",
            "--handle=0x0003",
            "--value=foovalue"
          ])
        )
      end
    end
  end
end
