control "inspec tfkit" do
  describe command("inspec tfkit") do
    its("stdout") { should match(/inspec tfkit help \[COMMAND\]/) }
    its("stdout") { should match(/inspec tfkit version/) }
  end
end

control "inspec tfkit version" do
  describe command("inspec tfkit version") do
    its("stdout") { should match(/tfkit v0.0.1/) }
  end
end
