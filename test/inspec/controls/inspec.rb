control "inspec CLI" do
  describe command("inspec") do
    its("stdout") { should match(/inspec tfkit/) }
    its("stdout") { should match(/inspec terraform SUBCOMMAND .../) }
    # its("stdout") { should match(/inspec cloudformation SUBCOMMAND .../) }
  end
end
