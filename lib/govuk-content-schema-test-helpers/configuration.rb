module GovukContentSchemaTestHelpers
  class ConfigurationError < StandardError; end

  class Configuration
    attr_writer :schema_type, :project_root

    def schema_type
      @schema_type || raise(ConfigurationError, 'GovukContentSchemaTestHelpers.configuration.schema_type must be set (and not nil)')
    end

    def project_root
      @project_root || raise(ConfigurationError, 'GovukContentSchemaTestHelpers.configuration.project_root must be set (and not nil)')
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield(configuration)
  end
end
