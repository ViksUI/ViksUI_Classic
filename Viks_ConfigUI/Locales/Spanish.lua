local _, L = ...
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

----------------------------------------------------------------------------------------
--	Localization for esES and esMX client
--	Translation: eXecrate
----------------------------------------------------------------------------------------
L_GUI_SET_SAVED_SETTTINGS = "Cambios aplicables sólo a este PJ"
L_GUI_SET_SAVED_SETTTINGS_DESC = "Switch between a profile that applies to all characters and one that is unique to this character." -- Need review
L_GUI_RESET_CHAR = "¿Estás seguro de que quieres reiniciar tus preferencias de ViksUI para este PJ?"
L_GUI_RESET_ALL = "¿Estás seguro de que quieres reiniciar tus preferencias de ViksUI para todos los PJs?"
L_GUI_PER_CHAR = "¿Estás segudo de que quieres cambiar a o desde 'Cambios sólo a este PJ'?"
L_GUI_NEED_RELOAD = "|cffff2735You need to reload the UI to apply your changes.|r" -- Need review

-- General options
L_GUI_GENERAL_SUBTEXT = "These settings control the general user interface settings. Type in chat '/uihelp' for help."
L_GUI_GENERAL_WELCOME_MESSAGE = "Welcome message in chat"
L_GUI_GENERAL_AUTOSCALE = "Auto UI Scale"
L_GUI_GENERAL_UISCALE = "UI Scale (if auto-scale is disabled)"
L.media_border_color = "Color for borders"
L.media_backdrop_color = "Color for borders backdrop"
L.media_overlay_color = "Color for action bars overlay"
L.media_pxcolor1 = "Color for Name on Datatex"
L.media_pxcolor2 = "Color for Value on Datatext if not dynamic color by value"
L.media_backdrop_alpha = "Alpha for transparent backdrop"
L.media_subheader_pixel = "Change Pixel font"
L.media_subheader_pixel2 = "Change Pixel font for Headers"
L.media_subheader_Dcolor = "Change color for DataTexts"

-- Font options
L.font = "Fonts" -- Need review
L.font_subtext = "Customize individual fonts for elements." -- Need review
L.font_stats_font = "Select font" -- Need review
L.font_stats_font_style = "Font flag" -- Need review
L.font_stats_font_shadow = "Font shadow" -- Need review
L.font_subheader_stats = "Stats font" -- Need review
L.font_subheader_combat = "Combat text font" -- Need review
L.font_subheader_chat = "Chat font" -- Need review
L.font_subheader_chat_tabs = "Chat tabs font" -- Need review
L.font_subheader_action = "Action bars font" -- Need review
L.font_subheader_threat = "Threat meter font" -- Need review
L.font_subheader_raidcd = "Raid cooldowns font" -- Need review
L.font_subheader_cooldown = "Cooldowns timer font" -- Need review
L.font_subheader_loot = "Loot font" -- Need review
L.font_subheader_nameplates = "Nameplates font" -- Need review
L.font_subheader_unit = "Unit frames font" -- Need review
L.font_subheader_aura = "Auras font" -- Need review
L.font_subheader_filger = "Filger font" -- Need review
L.font_subheader_style = "Stylization font" -- Need review
L.font_subheader_bag = "Bags font" -- Need review

-- Skins options
L_GUI_SKINS = "Stylization"
L_GUI_SKINS_SUBTEXT = "Change the appearance of the standard interface."
L_GUI_SKINS_BLIZZARD = "Enable styling Blizzard frames"
L_GUI_SKINS_MINIMAP_BUTTONS = "Enable styling addons icons on minimap"
L_GUI_SKINS_SUBHEADER = "Stylization of addons"
L_GUI_SKINS_ACE3 = "Ace3"
L_GUI_SKINS_ATLASLOOT = "AtlasLoot"
L_GUI_SKINS_BLOOD_SHIELD_TRACKER = "BloodShieldTracker"
L_GUI_SKINS_BW = "BigWigs"
L_GUI_SKINS_CAPPING = "Capping"
L_GUI_SKINS_CLIQUE = "Clique"
L_GUI_SKINS_COOL_LINE = "CoolLine"
L_GUI_SKINS_DBM = "DBM"
L_GUI_SKINS_DBM_MOVABLE = "Allow to move DBM bars"
L_GUI_SKINS_DOMINOS = "Dominos"
L_GUI_SKINS_FLYOUT_BUTTON = "FlyoutButtonCustom"
L_GUI_SKINS_LS_TOASTS = "ls: Toasts"
L_GUI_SKINS_MAGE_NUGGETS = "MageNuggets"
L_GUI_SKINS_MY_ROLE_PLAY = "MyRolePlay"
L_GUI_SKINS_NPCSCAN = "NPCScan"
L_GUI_SKINS_NUG_RUNNING = "NugRunning"
L_GUI_SKINS_OMEN = "Omen"
L_GUI_SKINS_OPIE = "OPie"
L_GUI_SKINS_OVALE = "OvaleSpellPriority"
L_GUI_SKINS_POSTAL = "Postal"
L_GUI_SKINS_RECOUNT = "Recount"
L_GUI_SKINS_REMATCH = "Rematch"
L_GUI_SKINS_SKADA = "Skada"
L_GUI_SKINS_TINY_DPS = "TinyDPS"
L_GUI_SKINS_VANASKOS = "VanasKoS"
L_GUI_SKINS_WEAK_AURAS = "WeakAuras"

-- Unit Frames options
L_GUI_UF_SUBTEXT = "Customize player, target frames and etc."
L_GUI_UF_ENABLE = "Enable unit frames"
L_GUI_UF_HEALFRAMES = "Use healer layout"
L_GUI_UF_OWN_COLOR = "Set your color for health bars"
L_GUI_UF_CLASS_COLOR = "Use Class Color on healthbars"
L_GUI_UF_UF_COLOR = "Color of Health Bars (if own color is enabled)"
L_GUI_UF_BG_COLOR = "Color of healthbar background"
L_GUI_UF_POWER_COLOR = "Use Class color for power bar"
L_GUI_UF_VUHDO = "Always Hide Raidframes if VuhDo is loaded"
L_GUI_UF_ENEMY_HEALTH_COLOR = "Enemy target healthbar is red"
L_GUI_UF_TOTAL_VALUE = "Display of info text on player and target with XXXX/Total"
L_GUI_UF_COLOR_VALUE = "Health/mana value is colored"
L_GUI_UF_BAR_COLOR_VALUE = "Health bar color by current health remaining"
L_GUI_UF_LINES = "Show Player and Target lines"
L_GUI_UF_SUBHEADER_CAST = "Castbars"
L_GUI_UF_UNIT_CASTBAR = "Show castbars"
L_GUI_UF_CASTBAR_ICON = "Show castbar icons"
L_GUI_UF_CASTBAR_LATENCY = "Castbar latency"
L_GUI_UF_CASTBAR_TICKS = "Castbar ticks"
L_GUI_UF_SUBHEADER_FRAMES = "Frames"
L_GUI_UF_SHOW_PET = "Pet"
L_GUI_UF_SHOW_FOCUS = "Focus"
L_GUI_UF_SHOW_FOCUST = "Target of focus"
L_GUI_UF_SHOW_TOT = "Target of target"
L_GUI_UF_SHOW_BOSS = "Bosses"
L_GUI_UF_SHOW_TANKS = "Main tanks"
L_GUI_UF_BOSS_RIGHT = "Boss frames on the right"
L_GUI_UF_SHOW_ARENA = "Arena"
L_GUI_UF_ARENA_RIGHT = "Arena frames on the right"
L_GUI_UF_BOSS_DEBUFFS = "Number of debuffs"
L_GUI_UF_BOSS_DEBUFFS_DESC = "Number of debuffs on the boss frames"
L_GUI_UF_BOSS_BUFFS = "Number of buffs"
L_GUI_UF_BOSS_BUFFS_DESC = "Number of buffs on the boss frames"
L_GUI_UF_ICONS_PVP = "Mouseover PvP text(not icons) on player and target frames"
L_GUI_UF_ICONS_COMBAT = "Combat icon"
L_GUI_UF_ICONS_RESTING = "Resting icon"
L_GUI_UF_SUBHEADER_PORTRAIT = "Portraits"
L_GUI_UF_PORTRAIT_ENABLE = "Enable player/target portraits"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Classcolor border for portraits"
L_GUI_UF_PORTRAIT_BARS = "Show portraits on Healthbar"
L_GUI_UF_PORTRAIT_HEIGHT = "Portrait height"
L_GUI_UF_PORTRAIT_WIDTH = "Portrait width"
L_GUI_UF_SUBHEADER_PLUGINS = "Plugins"
L_GUI_UF_PLUGINS_GCD = "Global cooldown spark on player frame"
L_GUI_UF_PLUGINS_SWING = "Enable swing bar"
L.unitframe_insideAlpha = "Alpha when Unitframe is in range"
L.unitframe_outsideAlpha = "Alpha when Unitframe is out of range"
L.unitframe_UFfont = "Unitframe font"
L.unitframe_UFNamefont = "Font to use on Names"
L.unitframe_plugins_reputation_bar = "Reputation bar"
L.unitframe_plugins_reputation_bar_desc = "Enable Reputation bar (left from player frame by mouseover)"
L.unitframe_plugins_experience_bar = "Experience bar"
L.unitframe_plugins_experience_bar_desc = "Enable Experience bar (left from player frame by mouseover)"
L.unitframe_plugins_artifact_bar = "Azerite Power bar"
L.unitframe_plugins_artifact_bar_desc = "Enable Azerite Power bar (left from player frame by mouseover)"
L.unitframe_plugins_auto_resurrection = "Auto cast resurrection"
L.unitframe_plugins_auto_resurrection_desc = "Auto cast resurrection on middle-click (doesn't work with Clique)"
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Smooth bar"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Show enemy talent spec in BG and Arena"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Combat text on player/target frame"
L_GUI_UF_PLUGINS_FADER = "Fade unit frames"
L_GUI_UF_PLUGINS_DIMINISHING = "Diminishing Returns icons on arena frames"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Power cost prediction bar on player frame"

-- Unit Frames Class bar options
L_GUI_UF_PLUGINS_CLASS_BAR = "Unit Frames Class bars" -- Needs review
L_GUI_UF_PLUGINS_CLASS_BAR_SUBTEXT = "Control of special class resources." -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR = "Iconos de puntos de combo de Pícaros/Druidas"
L_GUI_UF_PLUGINS_COMBO_BAR_ALWAYS = "Always show Combo bar for Druid" -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR_OLD = "Show combo point on the target" -- Need review
L_GUI_UF_PLUGINS_ARCANE_BAR = "Enable Arcane Charge bar" -- Need review
L_GUI_UF_PLUGINS_CHI_BAR = "Enable Chi bar" -- Needs review
L_GUI_UF_PLUGINS_STAGGER_BAR = "Enable Stagger bar (for Monk Tanks)" -- Need review
L_GUI_UF_PLUGINS_HOLY_BAR = "Activar barra de poder sagrado"
L_GUI_UF_PLUGINS_SHARD_BAR = "Activar barra de fragmentos"
L_GUI_UF_PLUGINS_RUNE_BAR = "Activar barra de Runas"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Activar barra de totems"
L_GUI_UF_PLUGINS_RANGE_BAR = "Enable Range bar (for Priest)" -- Needs review

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames."
L_GUI_UF_BY_ROLE = "Sorting players in group by role"
L_GUI_UF_AGGRO_BORDER = "Aggro border"
L_GUI_UF_DEFICIT_HEALTH = "Raid deficit health"
L_GUI_UF_SHOW_PARTY = "Show party frames"
L_GUI_UF_SHOW_RAID = "Show raid frames"
L_GUI_UF_VERTICAL_HEALTH = "Vertical orientation of health"
L_GUI_UF_ALPHA_HEALTH = "Alpha of healthbars when 100%hp"
L_GUI_UF_SHOW_RANGE = "Show range opacity for raidframes"
L_GUI_UF_RANGE_ALPHA = "Alpha"
L_GUI_UF_RANGE_ALPHA_DESC = "Alpha of unitframes when unit is out of range"
L_GUI_UF_SUBHEADER_RAIDFRAMES = "Frames"
L_GUI_UF_SOLO_MODE = "Show player frame always"
L_GUI_UF_PLAYER_PARTY = "Show player frame in party"
L_GUI_UF_SHOW_TANK = "Show raid tanks"
L_GUI_UF_SHOW_TANK_TT = "Show raid tanks target target"
L_GUI_UF_RAID_GROUP = "Number of groups in raid"
L_GUI_UF_RAID_ALLGROUP = "Show All 8 Raid Groups"
L_GUI_UF_RAID_VERTICAL_GROUP = "Vertical raid groups (only for heal layout)"
L_GUI_UF_SUBHEADER_ICONS = "Icons"
L_GUI_UF_ICONS_ROLE = "Roles"
L_GUI_UF_ICONS_RAID_MARK = "Raid marks"
L_GUI_UF_ICONS_READY_CHECK = "Ready check"
L_GUI_UF_ICONS_LEADER = "Leader and assistant"
L_GUI_UF_ICONS_SUMON = "Sumon icons"
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Debuff highlight texture + icon"
L_GUI_UF_PLUGINS_AURA_WATCH = "Raid debuff icons (from the list)"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Timer on raid debuff icons"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Show also PvP debuff icons (from the list)"
L_GUI_UF_PLUGINS_HEALCOMM = "Show incoming heal on frame"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection"
L.raidframe_plugins_auto_resurrection_desc = "Auto cast resurrection on middle-click (doesn't work with Clique)"

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Anuncios"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L_GUI_ANNOUNCEMENTS_DRINKING = "Anunciar en el chat cuando un enemigo en la arena beba"
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Anunciar en el grupo/banda cuando interrumpes"
L_GUI_ANNOUNCEMENTS_SPELLS = "Anunciar en grupo/banda cuando lanzas el mismo hechizo que otro"
L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL = "Comprueba los lanzamientos de hechizo de todos los miembros"
L_GUI_ANNOUNCEMENTS_TOY_TRAIN = "Announce Toy Train or Direbrew's Remote cast" -- Needs review
L_GUI_ANNOUNCEMENTS_SAYS_THANKS = "Says thanks for some spells" -- Needs review
L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN = "Pull countdown announce'/pc #'" -- Needs review
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Announce the usage of flasks and food" -- Needs review
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Auto announce when ReadyCheck" -- Needs review
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Announce to raid channel" -- Needs review
L_GUI_ANNOUNCEMENTS_FEASTS = "Announce Feasts/Souls/Repair Bots cast" -- Needs review
L_GUI_ANNOUNCEMENTS_PORTALS = "Announce Portals/Ritual of Summoning cast" -- Needs review
L_GUI_ANNOUNCEMENTS_BAD_GEAR = "Check bad gear in instance (fishing pole, from the list)" -- Needs review
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Check Safari Hat" -- Needs review

-- Automation options
L_GUI_AUTOMATION = "Automation" -- Needs review
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L_GUI_AUTOMATION_RELEASE = "Auto resurrección en los Campos de Batalla" -- Need review
L_GUI_AUTOMATION_SCREENSHOT = "Tomar una captura de pantalla cuando consigas un logro"
L_GUI_AUTOMATION_SOLVE_ARTIFACT = "Auto popup for solve artifact" -- Needs review
L_GUI_AUTOMATION_ACCEPT_INVITE = "Auto aceptar invitaciones"
L_GUI_AUTOMATION_DECLINE_DUEL = "Auto rechazar duelos"
L_GUI_AUTOMATION_ACCEPT_QUEST = "Auto aceptar misiones"
L_GUI_AUTOMATION_AUTO_COLLAPSE = "Auto collapse WatchFrame in instance" -- Needs review
L_GUI_AUTOMATION_AUTO_COLLAPSE_RELOAD = "Auto collapse ObjectiveTrackerFrame after reload" -- Need review
L_GUI_AUTOMATION_SKIP_CINEMATIC = "Auto skip cinematics/movies (disabled if hold Ctrl)" -- Needs review
L_GUI_AUTOMATION_AUTO_ROLE = "Auto set your role" -- Needs review
L_GUI_AUTOMATION_CANCEL_BAD_BUFFS = "Auto cancel various buffs" -- Needs review
L_GUI_AUTOMATION_TAB_BINDER = "Auto change Tab key to only target enemy players" -- Needs review
L_GUI_AUTOMATION_LOGGING_COMBAT = "Auto enables combat log text file in raid instances" -- Needs review
L_GUI_AUTOMATION_BUFF_ON_SCROLL = "Cast buff on mouse scroll" -- Needs review
L_GUI_AUTOMATION_OPEN_ITEMS = "Auto opening of items in bag" -- Needs review

-- Combat text options
L_GUI_COMBATTEXT = "Texto de Combate"
L_GUI_COMBATTEXT_SUBTEXT = "For moving type in the chat '/xct'" -- Need review
L_GUI_COMBATTEXT_ENABLE = "Activar Texto de Combate"
L.combattext_blizz_head_numbers = "Enable Blizzard combat text" -- Need review
L.combattext_blizz_head_numbers_desc = "Usar la salida de daño/curación de Blizzard (sobre la cabeza del monstruo/jugador)"
L.combattext_damage_style = "Change default combat font" -- Need review
L.combattext_damage_style_desc = "Cambiar la fuente de daño/sanación por defecto de encima de los monstruos/jugadores (tendrás que reiniciar WoW para ver los cambios)"
L_GUI_COMBATTEXT_DAMAGE = "Mostrar daño saliente en su propio marco"
L_GUI_COMBATTEXT_HEALING = "Mostrar sanación saliente en su propio marco"
L_GUI_COMBATTEXT_HOTS = "Mostrar efectos de cura periódicos en el marco de curas"
L_GUI_COMBATTEXT_OVERHEALING = "Mostrar la sobrecuracion saliente"
L_GUI_COMBATTEXT_PET_DAMAGE = "Mostrar el daño de tu mascota"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Mostrar el daño de tus dots (Daño periodico)"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Mostrar números de daño dependiendo de la escuela de magia"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Símbolo que se añadirá antes de un crítico"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Símbolo que se añadirá después de un crítico"
L_GUI_COMBATTEXT_ICONS = "Mostrar iconos de daño saliente"
L_GUI_COMBATTEXT_ICON_SIZE = "Icon size" -- Need review
L_GUI_COMBATTEXT_ICON_SIZE_DESC = "Tamaño de los iconos de los hechizos en el marco de daño saliente, también tiene efecto sobre el tamaño de la fuente de daño"
L_GUI_COMBATTEXT_TRESHOLD = "Daño mínimo que se mostrar en el marco de daño"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Sanación mínima que se mostrar en los mensajes de sanación entrante/saliente"
L_GUI_COMBATTEXT_SCROLLABLE = "Permitir usar la rueda del ratón para desplazar las líneas de los marcos"
L_GUI_COMBATTEXT_MAX_LINES = "Max lines" -- Need review
L_GUI_COMBATTEXT_MAX_LINES_DESC = "Máx de líneas para mantener desplazables (a más lineas, más memoria requerida)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Time" -- Need review
L_GUI_COMBATTEXT_TIME_VISIBLE_DESC = "Tiempo (segundos) en que un mensaje es visible"
L_GUI_COMBATTEXT_DK_RUNES = "Mostrar recarga de runas de los Caballeros de la Muerte"
L_GUI_COMBATTEXT_KILLINGBLOW = "Mostrar tus golpes de gracia"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Unir el spam de daño de area en un solo mensaje"
L_GUI_COMBATTEXT_MERGE_MELEE = "Merges multiple auto attack damage spam" -- Needs review
L_GUI_COMBATTEXT_DISPEL = "Mostrar tus disipaciones"
L_GUI_COMBATTEXT_INTERRUPT = "Mostrar tus interrupciones"
L_GUI_COMBATTEXT_DIRECTION = "Change scrolling direction from bottom to top" -- Need review
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Use short numbers ('25.3k' instead of '25342')" -- Need review

-- Buffs reminder options
L_GUI_REMINDER = "Recordatorio de Ventajas"
L_GUI_REMINDER_SUBTEXT = "Display of missed auras." -- Need review
L_GUI_REMINDER_SOLO_ENABLE = "Mostrar ventajas propias que faltan"
L_GUI_REMINDER_SOLO_SOUND = "Alerta sonora para avisar de ventajas propias"
L_GUI_REMINDER_SOLO_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_SOLO_SIZE_DESC = "Tamaño de los iconos de las ventajas propias"
L_GUI_REMINDER_SUBHEADER = "Raid buffs" -- Need review
L_GUI_REMINDER_RAID_ENABLE = "Mostrar ventajas que faltan en la Banda"
L_GUI_REMINDER_RAID_ALWAYS = "Mostrar Recordatorio de Ventajas siempre"
L_GUI_REMINDER_RAID_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_RAID_SIZE_DESC = "Tamaño de los iconos de las ventajas de la Banda"
L_GUI_REMINDER_RAID_ALPHA = "Transparent" -- Need review
L_GUI_REMINDER_RAID_ALPHA_DESC = "Icono transparente cuando la ventaja está presente"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_SUBTEXT = "Tracking raid abilities in the upper left corner." -- Need review
L_GUI_COOLDOWN_RAID_ENABLE = "Mostrar tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_HEIGHT = "Bars height" -- Need review
L_GUI_COOLDOWN_RAID_WIDTH = "Bars width" -- Need review
L_GUI_COOLDOWN_RAID_SORT = "Barras de tiempos de reutilización de la Banda ordenadas hacia arriba"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Sort by expiration time" -- Needs review
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Show self cooldowns" -- Needs review
L_GUI_COOLDOWN_RAID_ICONS = "Iconos de tiempos de reutilización de la Banda"
L_GUI_COOLDOWN_RAID_IN_RAID = "Mostrar tiempos de reutilización de la Banda en zona de Banda"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Mostrar tiempos de reutilización de la Banda en zona de Grupo"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Mostrar tiempos de reutilización de la Banda en zona de Arena"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_SUBTEXT = "Tracking enemy abilities as icons above your spell casting bar." -- Need review
L_GUI_COOLDOWN_ENEMY_ENABLE = "Activar tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_SIZE = "Tamaño del icono de tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Icono de dirección de tiempos de reutilización del enemigo"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Mostrar tiempos de reutilización del enemigo siempre"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Mostrar tiempos de reutilización del enemigo en zona de CB"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Mostrar tiempos de reutilización del enemigo en zona de Arena"

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Cuenta atrás de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SUBTEXT = "Track your cd using a pulse icon in the center of the screen." -- Need review
L_GUI_COOLDOWN_PULSE_ENABLE = "Mostrar cuentas atrás de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SIZE = "Tamaño de los icono de las cuentas atras de tiempos de reutilización"
L_GUI_COOLDOWN_PULSE_SOUND = "Aviso sonoro"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Escalado animado"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Opacidad máxima del tiempo de espera"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Threshold time" -- Need review
L_GUI_COOLDOWN_PULSE_THRESHOLD_DESC = "Umbral de tiempo mínimo"

-- Threat options
L_GUI_THREAT = "Barras de Amenaza"
L_GUI_THREAT_SUBTEXT = "Display of the threat list (a simple analogue of Omen)." -- Need review
L_GUI_THREAT_ENABLE = "Activar Barras de Amenaza"
L_GUI_THREAT_HEIGHT = "Altura de las barras de amenaza"
L_GUI_THREAT_WIDTH = "Anchura de las barras de amenaza"
L_GUI_THREAT_ROWS = "Número de barras de amenaza"
L_GUI_THREAT_HIDE_SOLO = "Mostrar solo en grupo/raid"

-- Tooltip options
L_GUI_TOOLTIP = "Descripciones"
L_GUI_TOOLTIP_SUBTEXT = "In this block, you can change the standard tips when mouseovering." -- Need review
L_GUI_TOOLTIP_ENABLE = "Activar descripciones"
L_GUI_TOOLTIP_SHIFT = "Mostrar descripción mientras Shift está pulsado"
L_GUI_TOOLTIP_CURSOR = "Descripción bajo el cursos"
L_GUI_TOOLTIP_ICON = "Icono del objeto en la descripción"
L_GUI_TOOLTIP_HEALTH = "Valor de la vida en números"
L_GUI_TOOLTIP_HIDE = "Ocultar descripciones de las barras de acción"
L_GUI_TOOLTIP_HIDE_COMBAT = "Ocultar descripción en combate"
L_GUI_TOOLTIP_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_TOOLTIP_TALENTS = "Mostrar descripción de los talentos"
L_GUI_TOOLTIP_ACHIEVEMENTS = "Comparar logros en la descripción"
L_GUI_TOOLTIP_TARGET = "Jugador objetivo en la descripción"
L_GUI_TOOLTIP_TITLE = "Player title in tooltip" -- Need review
L_GUI_TOOLTIP_REALM = "Player realm name in tooltip" -- Need review
L_GUI_TOOLTIP_RANK = "Rango del jugador en la hermandad en la descripción"
L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Experiencia JcJ del jugador en Arenas en la descripción"
L_GUI_TOOLTIP_SPELL_ID = "ID del hechizo"
L_GUI_TOOLTIP_AVERAGE_LVL_DESC = "The average item level" -- Need review
L_GUI_TOOLTIP_RAID_ICON = "Icono de banda"
L_GUI_TOOLTIP_WHO_TARGETTING = "Muestra quien está marcando la unidad que está en tu grupo/banda"
L_GUI_TOOLTIP_ITEM_COUNT = "Contador del objeto"
L_GUI_TOOLTIP_UNIT_ROLE = "Unit role" -- Needs review
L_GUI_TOOLTIP_INSTANCE_LOCK = "Your instance lock status in tooltip" -- Needs review

-- Chat options
L_GUI_CHAT_SUBTEXT = "Here you can change the settings of the chat window." -- Need review
L_GUI_CHAT_ENABLE = "Activar chat"
L_GUI_CHAT_BACKGROUND = "Activar fondo del chat"
L_GUI_CHAT_BACKGROUND_ALPHA = "Opacidad del fondo del chat"
L_GUI_CHAT_SPAM = "Remover ciertos mensajes de spam ('Jugador1' ha ganado un duelo a 'Jugador2')"
L_GUI_CHAT_GOLD = "Remover spam del algunos jugadores (Vendedores de oro)"
L_GUI_CHAT_WIDTH = "Anchura del chat"
L_GUI_CHAT_HEIGHT = "Altura del chat"
L_GUI_CHAT_BAR = "Pequeña barra de botones para cambiar de canal en el chat"
L_GUI_CHAT_BAR_MOUSEOVER = "Lite Button Bar on mouseover" -- Needs review
L_GUI_CHAT_TIMESTAMP = "Color de la marca de tiempo"
L_GUI_CHAT_WHISP = "Sonido cuando te susurran"
L_GUI_CHAT_SKIN_BUBBLE = "Estilizar las burbujas de chat"
L_GUI_CHAT_CL_TAB = "Mostrar la pestaña del Registro de Combate"
L_GUI_CHAT_TABS_MOUSEOVER = "Chat tabs on mouseover" -- Needs review
L_GUI_CHAT_STICKY = "Recordar último canal"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Merge damage meter spam in one line-link" -- Needs review

-- Bag options
L_GUI_BAGS = "Bolsas"
L_GUI_BAGS_SUBTEXT = "Changing the built-in bags." -- Need review
L_GUI_BAGS_ENABLE = "Activar bolsas"
L_GUI_BAGS_ILVL = "Show item level for weapons and armor" -- Need review
L_GUI_BAGS_BUTTON_SIZE = "Tamaño de los huecos"
L_GUI_BAGS_BUTTON_SPACE = "Espacio entre huecos"
L_GUI_BAGS_BANK = "Número de columnas en el banco"
L_GUI_BAGS_BAG = "Número de columnas en la bolsa principal"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap settings." -- Need review
L_GUI_MINIMAP_ENABLE = "Activar minimapa"
L_GUI_MINIMAP_ICON = "Icono de seguimiento"
L_GUI_GARRISON_ICON = "Garrison icon" -- Need review
L_GUI_MINIMAP_SIZE = "Tamaño del minimapa"
L_GUI_MINIMAP_HIDE_COMBAT = "Ocultar minimapa en combate"
L_GUI_MINIMAP_TOGGLE_MENU = "Show toggle menu" -- Needs review
L.minimap_bg_map_stylization = "Estilizado del mapa de CB"
L.minimap_fog_of_war = "Remove fog of war on World Map" -- Needs review
L.minimap_fog_of_war_desc = "Right click on the close button of World Map to activate the option to hide fog of war" -- Need review

-- Loot options
L_GUI_LOOT_SUBTEXT = "Settings for loot frame." -- Need review
L_GUI_LOOT_ENABLE = "Activar el marco de botín"
L_GUI_LOOT_ROLL_ENABLE = "Activar el marco de botín de grupo"
L_GUI_LOOT_ICON_SIZE = "Tamaño de los iconos"
L_GUI_LOOT_WIDTH = "Anchura del marco de botín"
L_GUI_LOOT_AUTOGREED = "Activar auto-codicia para objetos verdes cuando eres nivel máx"
L_GUI_LOOT_AUTODE = "Auto confirmar desencantar"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Nameplates settings" -- Need review
L_GUI_NAMEPLATE_ENABLE = "Activar placas de nombre"
L_GUI_NAMEPLATE_COMBAT = "Mostrar automáticamente placa de nombre en combate"
L_GUI_NAMEPLATE_HEALTH = "Valor de la vida en números"
L_GUI_NAMEPLATE_HEIGHT = "Altura de la placa de nombre"
L_GUI_NAMEPLATE_WIDTH = "Anchura de la placa de nombre"
L_GUI_NAMEPLATE_DISTANCE = "Display range" -- Need review
L_GUI_NAMEPLATE_AD_HEIGHT = "Additional height" -- Need review
L_GUI_NAMEPLATE_AD_WIDTH = "Additional width" -- Need review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Mostrar nombre del hechizo en la barra de lanzamiento"
L_GUI_NAMEPLATE_CLASS_ICON = "Iconos de clase en JcJ"
L_GUI_NAMEPLATE_NAME_ABBREV = "Mostrar los nombres abreviados"
L_GUI_NAMEPLATE_CLAMP = "Clamp nameplates to the top of the screen when outside of view" -- Need review
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Mostrar perjuicios (Nombres abreviados debe ser desactivado)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Show buffs above player nameplate (from the list)" -- Need review
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Tamaño de los perjuicios"
L_GUI_NAMEPLATE_HEALER_ICON = "Show icon above enemy healers nameplate in battlegrounds" -- Needs review
L_GUI_NAMEPLATE_TOTEM_ICONS = "Show icon above enemy totems nameplate" -- Need review
L_GUI_NAMEPLATE_THREAT = "Activar visor de amenaza, cambia automáticamente según tu rol"
L_GUI_NAMEPLATE_GOOD_COLOR = "Color de alta amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_NEAR_COLOR = "Color de perdiendo/ganando amenaza"
L_GUI_NAMEPLATE_BAD_COLOR = "Color de baja amenaza, varía dependiendo si eres tanque o dps/sanador"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Offtank threat color" -- Need review

-- ActionBar options
L_GUI_ACTIONBAR = "Action Bars" -- Need review
L_GUI_ACTIONBAR_ENABLE = "Activar barras de acción"
L_GUI_ACTIONBAR_HOTKEY = "Mostrar texto los atajos de teclado"
L_GUI_ACTIONBAR_MACRO = "Mostrar nombre de la macro en los botones"
L_GUI_ACTIONBAR_GRID = "Mostrar botones de la barra de acción vacíos"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Tamaño de los botones"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Espacio entre botones"
L_GUI_ACTIONBAR_SPLIT_BARS = "Dividir la quinta barra en dos de 6 botones cada una"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Activar borde por color de clase para los botones"
L_GUI_ACTIONBAR_TOGGLE_MODE = "Activar modo cambiar"
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "Hide proc highlight" -- Needs review
L_GUI_ACTIONBAR_BOTTOMBARS = "Número de barras de acción abajo"
L_GUI_ACTIONBAR_RIGHTBARS = "Número de barras de acción en la derecha"
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barras de la derecha se muestran al pasar el ratón"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Ocultar barra de mascota"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Activar barra de mascota horizontal"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barra de mascota al pasar el ratón (sólo para la barra de mascota horizontal)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Ocultar cambio de forma"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Activar barra de estancia horizontal"
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Barras de Cambios de forma/Estancias al pasar el ratón" -- Needs review
L_GUI_ACTIONBAR_MICROMENU = "Enable micro menu" -- Needs review
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micro menu on mouseover" -- Needs review

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs size" -- Need review
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Tamaño de las beneficios del jugador"
L_GUI_AURA_SHOW_SPIRAL = "Espiral en los iconos de las auras"
L_GUI_AURA_SHOW_TIMER = "Mostrar tiempo de reutilización en los iconos de las auras"
L_GUI_AURA_PLAYER_AURAS = "Auras en el marco del jugador"
L_GUI_AURA_TARGET_AURAS = "Auras en el marco del objetivo"
L_GUI_AURA_FOCUS_DEBUFFS = "Perjuicios en el marco del foco"
L_GUI_AURA_FOT_DEBUFFS = "Perjuicios en el marco del objetivo del foco"
L_GUI_AURA_PET_DEBUFFS = "Perjuicios en el marco de la mascota"
L_GUI_AURA_TOT_DEBUFFS = "Perjuicios en el marco del objetivo del objetivo"
L_GUI_AURA_BOSS_BUFFS = "Beneficios en el marco del jefe"
L_GUI_AURA_PLAYER_AURA_ONLY = "Solo tus perjuicios en el marco del objetivo"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Color de los perjuicios por tipo"
L_GUI_AURA_CAST_BY = "Mostrar quién lanza un beneficio/perjuicio en su descripción"
L_GUI_AURA_CLASSCOLOR_BORDER = "Activar borde por color de clase para los beneficios del jugador"

-- Filger
L_GUI_FILGER = "Timers (Filger)"
L_GUI_FILGER_SUBTEXT = "Filger - analogue WeakAuras, but more simple and easy. Allows you to display in the form of icons and bars your auras and timers."
L_GUI_FILGER_ENABLE = "Enable Filger"
L_GUI_FILGER_TEST_MODE = "Test icon mode"
L_GUI_FILGER_MAX_TEST_ICON = "The number of icons to the test"
L_GUI_FILGER_SHOW_TOOLTIP = "Show tooltip"
L_GUI_FILGER_DISABLE_CD = "Disable cooldowns"
L_GUI_FILGER_DISABLE_PVP = "Disable PvP debuffs on Player and Target"
L_GUI_FILGER_EXPIRATION = "Sort cooldowns by expiration time"
L_GUI_FILGER_BUFFS_SIZE = "Buffs size"
L_GUI_FILGER_COOLDOWN_SIZE = "Cooldowns size"
L_GUI_FILGER_PVP_SIZE = "Debuffs size"
L_GUI_FILGER_PROC_SIZE = "Proc icon size"
L_GUI_FILGER_BARICON_SIZE = "Bar icon size"

-- Panel options
L_GUI_TOP_PANEL = "Panel superior"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Activar panel superior"
L_GUI_TOP_PANEL_MOUSE = "Panel superior al pasar el ratón"
L_GUI_TOP_PANEL_WIDTH = "Anchura del panel"
L_GUI_TOP_PANEL_HEIGHT = "Altura del panel"

-- Stats options
L_GUI_STATS = "Estadísticas"
L_GUI_STATS_SUBTEXT = "Statistics blocks located at the bottom of the screen. Type in the chat '/ls' for info." -- Need review
L_GUI_STATS_CLOCK = "Reloj"
L_GUI_STATS_LATENCY = "Latencia"
L_GUI_STATS_MEMORY = "Memoria"
L_GUI_STATS_FPS = "FPS (Marcos por segundo)"
L_GUI_STATS_EXPERIENCE = "Experiencia"
L_GUI_STATS_TALENTS_DESC = "Date-text allows you to change the spec and loot on click" -- Need review
L_GUI_STATS_COORDS = "Coordenadas"
L_GUI_STATS_LOCATION = "Localización"
L_GUI_STATS_BG = "Campo de Batalla"
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Show Archaeology Fragments" -- Needs review
L_GUI_STATS_CURRENCY_COOKING = "Show Cooking Awards" -- Needs review
L_GUI_STATS_CURRENCY_PROFESSIONS = "Show Profession Tokens" -- Needs review
L_GUI_STATS_CURRENCY_RAID = "Show Raid Seals" -- Needs review
L_GUI_STATS_CURRENCY_MISCELLANEOUS = "Show Miscellaneous Currency" -- Needs review

-- Panels options
L_GUI_PANELS = "Panels" -- Needs review
L_GUI_PANELS_SUBTEXT = "Manage all the panels on screen." -- Needs review
L.panels_CPwidth = "Chat Width" -- Needs review
L.panels_CPwidth_desc = "Width for Left and Right side panels that holds text" -- Needs review
L.panels_CPLwidth = "Chat Lines." -- Needs review
L.panels_CPLwidth_desc = "Width for Left and Right Chat lines." -- Needs review
L.panels_CPTextheight = "Chat Hight" -- Needs review
L.panels_CPTextheight_desc = "Hight for the panel that chat window is inside" -- Needs review
L.panels_CPbarsheight = "Chat Bar Hight" -- Needs review
L.panels_CPbarsheight_desc = "Hight for panels that shows under and above chat window. And Top Panel" -- Needs review
L.panels_CPABarSide = "Side Action Bar" -- Needs review
L.panels_CPABarSide_desc = "Width for Action Bars next to chat windows" -- Needs review
L.panels_CPXPBa_r = "Xp Bar" -- Needs review
L.panels_CPXPBa_r_desc = "Hight for the XP bar above Left Chat" -- Needs review
L.panels_xoffset = "X Offset" -- Needs review
L.panels_xoffset_desc = "Horisontal spacing between panels" -- Needs review
L.panels_yoffset = "Y Offset" -- Needs review
L.panels_yoffset_desc = "Vertical spacing between panels" -- Needs review
L.panels_CPSidesWidth = "Addon Panels" -- Needs review
L.panels_CPSidesWidth_desc = "Width of panels that is used to hold dmg meter and threathbar (Recount & Omen)" -- Needs review
L.panels_CPMABwidth = "Width Main Actionbar" -- Needs review
L.panels_CPMABwidth_desc = "Width for panel behind main action bar" -- Needs review
L.panels_CPMABheight = "Hight For Main Actionbar" -- Needs review
L.panels_CPMABheight_desc = "Hight for panel behind main action bar" -- Needs review
L.panels_CPMAByoffset = "Y Offset Actionbar" -- Needs review
L.panels_CPMAByoffset_desc = "Main action bar panel placement distance from bottom of screen" -- Needs review
L.panels_CPCooldheight = "Cooldown Bar" -- Needs review
L.panels_CPCooldheight_desc = "Hight For Cooldown Panel under main action bar panel" -- Needs review
L.panels_CPTop = "Top Panels" -- Needs review
L.panels_CPTop_desc = "Width For Top Panel" -- Needs review
L.panels_Pscale = "Can Be Used To Resize All Panels. It Does Not Change X Y Values" -- Needs review
L.panels_Pscale_desc = "Can Be Used To Resize All Panels. It Does Not Change X Y Values" -- Needs review
L.panels_NoPanels = "Will Set All Panels To Hidden And Show Lines Instead. On Test Stage Still!" -- Needs review
L.panels_NoPanels_desc = "Will Set All Panels To Hidden And Show Lines Instead. On Test Stage Still!" -- Needs review
L.panels_HideABPanels = "Hides Actionbars Panels" -- Needs review
L.panels_HideABPanels_desc = "Hides All Panels Behind Actionbars!" -- Needs review

-- Error options
L_GUI_ERROR = "Errores"
L_GUI_ERROR_SUBTEXT = "Filtering standard text at the top of the screen from Blizzard." -- Need review
L_GUI_ERROR_BLACK = "Ocultar errores de la lista negra"
L_GUI_ERROR_WHITE = "Mostrar errores de la lista blanca"
L_GUI_ERROR_HIDE_COMBAT = "Hide all errors in combat" -- Needs review

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features."
L.misc_shift_marking = "Marks mouseover target"
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)"
L_GUI_MISC_INVKEYWORD = "Short keyword for invite (/ainv)"
L_GUI_MISC_SPIN_CAMERA = "Spin camera while afk"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Vehicle frame on mouseover"
L_GUI_MISC_QUEST_AUTOBUTTON = "Quest/item auto button (from the list)"
L.misc_raid_tools = "Raid tools"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)"
L_GUI_MISC_PROFESSION_TABS = "Professions tabs on tradeskill/trade frames"
L_GUI_MISC_HIDE_BG_SPAM = "Remove Boss Emote spam during BG"
L.misc_hide_bg_spam_desc = "Remove Boss Emote spam about capture/losing node during BG Arathi and Gilneas"
L_GUI_MISC_ITEM_LEVEL = "Item level on character slot buttons"
L_GUI_MISC_ALREADY_KNOWN = "Colorizes recipes/mounts/pets/toys that is already known"
L_GUI_MISC_DISENCHANTING = "Milling, Prospecting and Disenchanting by Alt + click"
L_GUI_MISC_SUM_BUYOUTS = "Sum up all current auctions"
L_GUI_MISC_CLICK_CAST = "Simple click2cast spell binder"
L_GUI_MISC_CLICK_CAST_FILTER = "Ignore Player and Target frames"
L_GUI_MISC_MOVE_BLIZZARD = "Move some Blizzard frames"
L_GUI_MISC_COLOR_PICKER = "Improved ColorPicker"
L_GUI_MISC_ENCHANTMENT_SCROLL = "Enchantment scroll on TradeSkill frame"
L_GUI_MISC_ARCHAEOLOGY = "Archaeology artifacts and cooldown"
L_GUI_MISC_CHARS_CURRENCY = "Tracks your currency tokens across multiple characters"
L.misc_armory_link = "Add Armory link"
L.misc_armory_link_desc = "Add the Armory link in the chat menu and target (but it will not be possible to set the focus through the target menu)"
L_GUI_MISC_MERCHANT_ITEMLEVEL = "Show item level for weapons and armor in merchant"
L_GUI_MISC_MINIMIZE_MOUSEOVER = "Mouseover for quest minimize button"
L_GUI_MISC_HIDE_BANNER = "Hide Boss Banner Loot Frame"
L_GUI_MISC_HIDE_TALKING_HEAD = "Hide Talking Head Frame"
L_GUI_MISC_HIDE_RAID_BUTTON = "Hide button for oUF_RaidDPS (top left corner)"
L_GUI_MISC_LAG_TOLERANCE = "Automatically update the Blizzard Custom Lag Tolerance option to your latency"
L_GUI_MISC_MARKBAR = "Markbar for Raid Icons and flares"
L_GUI_MISC_CLASSTIMER = "Shows buff/debuffs/procs as bar on player/target frame"
L_GUI_MISC_WATCHFRAME = "Use custom Quest watch frame"
L_GUI_MISC_BT4BARS = "Panels behind Sidebar & Small bars for Bartender 4"
L_GUI_MISC_PSCALE = "Scale ViksUI Panels"
L_GUI_MISC_PANELSH = "Set UI Panels to hidden"

-- DataText options
L_GUI_DATATEXT = "DataText"
L_GUI_DATATEXT_SUBTEXT = "DataText positions. From left to right. Bottom is nr 1 to 6 and Top is 7 to 13."
L_GUI_DATATEXT_Arena = "Arena Score" 
L_GUI_DATATEXT_Armor = "Armor Value"
L_GUI_DATATEXT_RunSpeed = "Run Speed"
L_GUI_DATATEXT_Avd = "Avoidance"
L_GUI_DATATEXT_Bags = "Bag Space"
L_GUI_DATATEXT_Battleground = "Enable 3 stats in battleground only that replace stat1,stat2,stat3"
L_GUI_DATATEXT_Crit = "Crit"
L_GUI_DATATEXT_Durability = "Durability"
L_GUI_DATATEXT_Friends = "Friends List"
L_GUI_DATATEXT_Gold = "Gold"
L_GUI_DATATEXT_Guild = "Guild"
L_GUI_DATATEXT_Haste = "Haste"
L_GUI_DATATEXT_Versatility = "Versatility"
L_GUI_DATATEXT_location = "Location"
L_GUI_DATATEXT_showcoords = "Coordinates on location"
L_GUI_DATATEXT_Mastery = "Mastery"
L_GUI_DATATEXT_Power = "Power"
L_GUI_DATATEXT_Regen = "Mana regeneration"
L_GUI_DATATEXT_System = "Fps and MS"
L_GUI_DATATEXT_Talents = "Talent"
L_GUI_DATATEXT_togglemenu = "Minimenu"
L_GUI_DATATEXT_Volume = "Volume"
L_GUI_DATATEXT_Wowtime = "THIS IS BLOCKED TO FIXED POSITION! SO CAN'T BE CHANGED HERE! NUMBER MUST BE > 0, BUT DOESN'T USE UP A SPOT!"
L_GUI_DATATEXT_Time24 = "Set time to 24h format"
L_GUI_DATATEXT_Localtime = "Show Local time instead of server time"
L_GUI_DATATEXT_classcolor = "Use Class Color in text"
L_GUI_DATATEXT_color = "Color to use it not Class color"
L_GUI_DATATEXT_SUBHEADER_CURRENCY = "Options"
L_GUI_DATATEXT_CurrArchaeology = "Archaeology Fragments under gold"
L_GUI_DATATEXT_CurrCooking = "Cooking Awards under gold"
L_GUI_DATATEXT_CurrProfessions = "Profession Tokens under gold"
L_GUI_DATATEXT_CurrMiscellaneous = "Miscellaneous Currency under gold"
L_GUI_DATATEXT_CurrPvP = "PVP Currency under gold"
L_GUI_DATATEXT_CurrRaid = "Raid Seals under gold"
L_GUI_DATATEXT_Quests = "Quest position"
L_GUI_DATATEXT_Bfamissions = "BFA Missions"