# SnowFlake

SnowFlake generates a unique ID

Implemented with reference to [Twitter snowflake](https://github.com/twitter/snowflake/tree/snowflake-2010)

# Example

```ruby
require 'snow_flake'

SnowFlake.setup do |config|
  config.generation_start_time = Time.parse('2017-01-01 10:00:00')
  config.machine_id = 1
end

SnowFlake.id
# => 30581323747823617
```
