local user_config = require('cosmic.core.user')

-- Вместо table.insert используем прямую вставку конфига плагина
local windsurf_spec = require('cosmic.plugins.windsurf')


-- Добавляем в таблицу плагинов
table.insert(user_config.add_plugins, windsurf_spec)

return user_config.add_plugins
