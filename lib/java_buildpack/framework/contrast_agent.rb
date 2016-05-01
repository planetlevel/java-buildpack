# Encoding: utf-8
# Cloud Foundry Java Buildpack
# Copyright 2013-2016 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'java_buildpack/component/versioned_dependency_component'
require 'java_buildpack/framework'
require 'net/http'

module JavaBuildpack
  module Framework

    # Encapsulates the functionality for enabling zero-touch Contrast support.
    class ContrastAgent < JavaBuildpack::Component::BaseComponent

      # (see JavaBuildpack::Component::BaseComponent#detect)
      def detect
		  exit 0
	  end

      # (see JavaBuildpack::Component::BaseComponent#compile)
      def compile
        @droplet.copy_resources
      end

      # (see JavaBuildpack::Component::BaseComponent#release)
      def release
        java_opts = @droplet.java_opts
        java_opts
          .add_javaagent(@droplet.sandbox + jar_name)
          .add_system_property('contrast.home', @droplet.sandbox)
      end

      def write_java_opts(java_opts, configuration)
        configuration.each do |key, value|
          java_opts.add_system_property("newrelic.config.#{key}", value)
        end
      end


    end
  end
end
