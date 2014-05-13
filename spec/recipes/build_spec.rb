require 'chefspec'
require 'chefspec/berkshelf'
ChefSpec::Coverage.start!

platforms = {
  "ubuntu" => ['12.04', '13.10'],
  "centos" => ['5.9', '6.5']
}

describe 'preview::build' do

  platforms.each do |platform_name, platform_versions|

    platform_versions.each do |platform_version|

      context "on #{platform_name} #{platform_version}" do

        let(:chef_run) do
          ChefSpec::Runner.new(platform: platform_name, version: platform_version).converge('preview::build')
        end

        it 'includes dependent receipes' do
          expect(chef_run).to include_recipe('golang::default')
          expect(chef_run).to include_recipe('golang::package')
        end

      end

    end

  end

end
