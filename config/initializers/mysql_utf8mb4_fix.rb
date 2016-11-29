require 'active_record/connection_adapters/abstract_mysql_adapter'
module ActiveRecord
  module ConnectionAdapters
    #
    # AbstractMysqlAdapter
    #
    # @author rashid
    #
    class AbstractMysqlAdapter
      NATIVE_DATABASE_TYPES[:string] = { name: 'varchar', limit: 191 }
    end
  end
end
