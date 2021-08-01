# Notice, this is just a plain ruby object.
class ErrorModel
  include Swagger::Blocks

  swagger_schema :ErrorModel do
    key :required, %i[status messages]
    property :staus do
      key :type, :string
    end
    property :messages do
      key :type, :array
      items do
        key :type, :string
      end
    end
  end
end
