VCARD = (() ->
  m = {}

  #generate takes a json object and converts it to a vcard
  m.generate = (json) ->
    string = ""
    string += "BEGIN:VCARD\r\n"
    for k,v of json
      switch k
        when "version" then string += "VERSION:#{v}\r\n"
        when "fn" then string += generate_fn(json.fn)
        when "n" then string += generate_n(json.n)
        when "nickname" then string += generate_nickname(json.nickname)
        when "photos"
          for photo in json.photos
            string += generate_photo(photo)
        when "bday" then string += generate_bday(json.bday)
        when "adrs"
          for adr in json.adrs
            string += generate_adr(adr)
        when "labels"
          for label in json.labels
            string += generate_label(label)
        when "tels"
          for tel in json.tels
            string += generate_tel(tel)
        when "emails"
          for email in json.emails
            string += generate_email(email)
        when "mailer" then string += generate_mailer(json.mailer)
        when "tz" then string += generate_tz(json.tz)
        when "geo" then string += generate_geo(json.geo)
        when "titles"
          for title in json.titles
            string += generate_title(title)
        when "roles"
          for role in json.roles
            string += generate_role(role)
        when "logos"
          for logo in json.logos
            string += generate_logo(logo)
        when "orgs"
          for org in json.orgs
            string += generate_org(org)
        when "categories" then string += generate_categories(json.categories)
        when "notes"
          for note in json.notes
            string += generate_note(note)
        when "prodid" then string += generate_prodid(json.prodid)
        when "rev" then string += generate_rev(json.rev)
        when "sort_string" then string += generate_sort_string(json.sort_string)
        when "sounds"
          for sound in json.sounds
            string += generate_sound(sound)
        when "uid" then string += generate_uid(json.uid)
        when "urls"
          for url in json.urls
            string += generate_url(url)
        when "classes"
          for klass in json.classes
            string += generate_class(klass)
        when "key" then string += generate_key(json.key)
    string += "END:VCARD"
  
  #parse takes a vcard string and converts it to a json object
  m.parse = (string) ->
    stringlines = string.split(/\r?\n/)
    newlines = []
    for line in stringlines
      unless line.match(/BEGIN:VCARD|END:VCARD/)
        newlines.push(parse_line(line))
    lines = {}
    for newline in newlines
      switch newline.name
        when "VERSION" then lines.version = newline.value
        when "FN" then lines.fn = parse_fn(newline)
        when "N" then lines.n = parse_n(newline)
        when "NICKNAME" then lines.nickname = parse_nickname(newline)
        when "PHOTO"
          lines.photos || lines.photos = []
          lines.photos.push(parse_photo(newline))
        when "BDAY" then lines.bday = parse_bday(newline)
        when "ADR"
          lines.adrs || lines.adrs = []
          lines.adrs.push(parse_adr(newline))
        when "LABEL"
          lines.labels || lines.labels = []
          lines.labels.push(parse_label(newline))
        when "TEL"
          lines.tels || lines.tels = []
          lines.tels.push(parse_tel(newline))
        when "EMAIL"
          lines.emails || lines.emails = []
          lines.emails.push(parse_email(newline))
        when "MAILER" then lines.mailer = parse_mailer(newline)
        when "TZ" then lines.tz = parse_tz(newline)
        when "GEO" then lines.geo = parse_geo(newline)
        when "TITLE"
          lines.titles || lines.titles = []
          lines.titles.push(parse_title(newline))
        when "ROLE"
          lines.roles || lines.roles = []
          lines.roles.push(parse_role(newline))
        when "LOGO"
          lines.logos || lines.logos = []
          lines.logos.push(parse_logo(newline))
        when "ORG"
          lines.orgs || lines.orgs = []
          lines.orgs.push(parse_org(newline))
        when "CATEGORIES" then lines.categories = parse_categories(newline)
        when "NOTE"
          lines.notes || lines.notes = []
          lines.notes.push(parse_note(newline))
        when "PRODID" then lines.prodid = parse_prodid(newline)
        when "REV" then lines.rev = parse_rev(newline)
        when "SORT-STRING" then lines.sort_string = parse_sort_string(newline)
        when "SOUND"
          lines.sounds || lines.sounds = []
          lines.sounds.push(parse_sound(newline))
        when "UID" then lines.uid = parse_uid(newline)
        when "URL"
          lines.urls || lines.urls = []
          lines.urls.push(parse_url(newline))
        when "CLASS"
          lines.classes || lines.classes = []
          lines.classes.push(parse_class(newline))
        when "KEY" then lines.key = parse_key(newline)
    lines

  #private functions
  parse_line = (string) ->
    json = {}
    res = string.match(/^(?:(\w+)\.)?([a-zA-Z-_]+)((?:;[a-zA-Z0-9-_]+=[a-zA-Z0-9-,]+)+)?:((?:.|\n)+)$/)
    json.group = res[1] if res[1]
    json.name = res[2]
    if res[3]
      json.params = parse_params(res[3])
    json.value = res[4]
    json

  #parse functions
  parse_params = (string) ->
    params = string.split(";")
    params.shift()
    json = {}
    for param in params
      k = param.split("=")[0]
      v = param.split("=")[1]
      json[k.toLowerCase()] = v.toLowerCase()
    json

  parse_fn = (json) ->
    fn = {}
    fn.group = json.group if json.group
    if json.params
      for k,v of json.params
        fn.params || fn.params = {}
        fn.params[k] = v if k.match(/value|language|x-\w+/i)
    fn.name = json.value
    fn

  parse_n = (json) ->
    n = {}
    n.group = json.group if json.group
    if json.params
      for k,v of json.params
        n.params || n.params = {}
        n.params[k] = v if k.match(/value|language|x-\w+/i)
    names = json.value.split(';')

    n.families = names[0].split(',') if names[0]
    n.givens = names[1].split(',') if names[1]
    n.middles = names[2].split(',') if names[2]
    n.prefixes = names[3].split(',') if names[3]
    n.suffixes = names[4].split(',') if names[4]
    n

  parse_nickname = (json) ->
    nickname = {}
    nickname.group = json.group if json.group
    if json.params
      for k,v of json.params
        nickname.params || nickname.params = {}
        nickname.params[k] = v if k.match(/value|language|x-\w+/i)
    names = json.value.split(',')
    nickname.names = names
    nickname

  parse_photo = (json) ->
    photo = {}
    photo.group = json.group if json.group
    if json.params
      for k,v of json.params
        photo.params || photo.params = {}
        photo.params[k] = v if k.match(/value|encoding|type/i)
    photo.image = json.value
    photo

  parse_bday = (json) ->
    res = json.value.match(/^(\d{4})-(\d{2})-(\d{2})(?:T(\d{2}):(\d{2}):(\d{2})Z)?$/)
    bday = {}
    bday.group = json.group if json.group
    if json.params
      for k,v of json.params
        bday.params || bday.params = {}
        bday.params[k] = v if k.match(/value/i)
    bday.year = res[1]
    bday.month = res[2]
    bday.day = res[3]
    if json.params && json.params.value && json.params.value.match(/date-time/i)
      bday.hour = res[4] if res[4]
      bday.minute = res[5] if res[5]
      bday.second = res[6] if res[6]
    bday

  parse_adr = (json) ->
    adr = {}
    adr.group = json.group if json.group
    if json.params
      for k,v of json.params
        adr.params || adr.params = {}
        adr.params[k] = v if k.match(/value|language|x-\w+/i)
        if k.match("type")
          adr.params.types || adr.params.types = []
          if v.match(/,/)
            arr = v.split(',')
            for a in arr
              adr.params.types.push(a)
          else
            adr.params.types.push(v)
    res = json.value.split(';')
    adr.pobox = res[0] if res[0]
    adr.extended = res[1] if res[1]
    adr.street = res[2] if res[2]
    adr.locality = res[3] if res[3]
    adr.region = res[4] if res[4]
    adr.code = res[5] if res[5]
    adr.country = res[6] if res[6]
    adr

  parse_label = (json) ->
    label = {}
    label.group = json.group if json.group
    if json.params
      for k,v of json.params
        label.params || label.params = {}
        label.params[k] = v if k.match(/value|language|x-\w+/i)
        if k.match("type")
          label.params.types || label.params.types = []
          if v.match(/,/)
            arr = v.split(',')
            for a in arr
              label.params.types.push(a)
          else
            label.params.types.push(v)
    label.address = json.value
    label

  parse_tel = (json) ->
    tel = {}
    tel.group = json.group if json.group
    if json.params
      for k,v of json.params
        if k.match("type")
          tel.params || tel.params = {}
          tel.params.types || tel.params.types = []
          if v.match(/,/)
            arr = v.split(',')
            for a in arr
              tel.params.types.push(a)
          else
            tel.params.types.push(v)
    tel.number = json.value
    tel

  parse_email = (json) ->
    email = {}
    email.group = json.group if json.group
    if json.params
      for k,v of json.params
        if k.match("type")
          email.params || email.params = {}
          email.params.types || email.params.types = []
          if v.match(/,/)
            arr = v.split(',')
            for a in arr
              email.params.types.push(a)
          else
            email.params.types.push(v)
    email.address = json.value
    email

  parse_mailer = (json) ->
    mailer = {}
    mailer.group = json.group if json.group
    if json.params
      for k,v of json.params
        mailer.params || mailer.params = {}
        mailer.params[k] = v if k.match(/value|language|x-\w+/i)
    mailer.name = json.value
    mailer

  parse_tz = (json) ->
    tz = {}
    tz.group = json.group if json.group
    if json.params
      for k,v of json.params
        tz.params || tz.params = {}
        tz.params[k] = v if k.match(/value/i)
    tz.zone = json.value
    tz

  parse_geo = (json) ->
    geo = {}
    geo.group = json.group if json.group
    res = json.value.split(';')
    geo.latitude = res[0]
    geo.longitude = res[1]
    geo

  parse_title = (json) ->
    title = {}
    title.group = json.group if json.group
    if json.params
      for k,v of json.params
        title.params || title.params = {}
        title.params[k] = v if k.match(/value|language|x-\w+/i)
    title.name = json.value
    title

  parse_role = (json) ->
    role = {}
    role.group = json.group if json.group
    if json.params
      for k,v of json.params
        role.params || role.params = {}
        role.params[k] = v if k.match(/value|language|x-\w+/i)
    role.name = json.value
    role

  parse_logo = (json) ->
    logo = {}
    logo.group = json.group if json.group
    if json.params
      for k,v of json.params
        logo.params || logo.params = {}
        logo.params[k] = v if k.match(/value|encoding|type/i)
    logo.image = json.value
    logo

  parse_org = (json) ->
    org = {}
    org.group = json.group if json.group
    if json.params
      for k,v of json.params
        org.params || org.params = {}
        org.params[k] = v if k.match(/value|language|x-\w+/i)
    res = json.value.split(';')
    org.name = res[0] if res[0]
    org.unit = res[1] if res[1]
    org.unit2 = res[2] if res[2]
    org

  parse_categories = (json) ->
    categories = {}
    categories.group = json.group if json.group
    if json.params
      for k,v of json.params
        categories.params || categories.params = {}
        categories.params[k] = v if k.match(/value|language|x-\w+/i)
    categories.names = json.value.split(',')
    categories

  parse_note = (json) ->
    note = {}
    note.group = json.group if json.group
    if json.params
      for k,v of json.params
        note.params || note.params = {}
        note.params[k] = v if k.match(/value|language|x-\w+/i)
    note.description = json.value
    note

  parse_prodid = (json) ->
    prodid = {}
    prodid.group = json.group if json.group
    prodid.id = json.value 
    prodid

  parse_rev = (json) ->
    res = json.value.match(/^(\d{4})-(\d{2})-(\d{2})(?:T(\d{2}):(\d{2}):(\d{2})Z)?$/)
    rev = {}
    rev.group = json.group if json.group
    if json.params
      for k,v of json.params
        rev.params || rev.params = {}
        rev.params[k] = v if k.match(/value/i)
    rev.year = res[1]
    rev.month = res[2]
    rev.day = res[3]
    rev.hour = res[4] if res[4]
    rev.minute = res[5] if res[5]
    rev.second = res[6] if res[6]
    rev

  parse_sort_string = (json) ->
    sort_string = {}
    sort_string.group = json.group if json.group
    if json.params
      for k,v of json.params
        sort_string.params || sort_string.params = {}
        sort_string.params[k] = v if k.match(/value|language|x-\w+/i)
    sort_string.name = json.value
    sort_string

  parse_sound = (json) ->
    sound = {}
    sound.group = json.group if json.group
    if json.params
      for k,v of json.params
        sound.params || sound.params = {}
        sound.params[k] = v if k.match(/value|encoding|type/i)
    sound.value = json.value
    sound

  parse_uid = (json) ->
    uid = {}
    uid.group = json.group if json.group
    if json.params
      for k,v of json.params
        uid.params || uid.params = {}
        uid.params[k] = v if k.match(/type/i)
    uid.id = json.value
    uid

  parse_url = (json) ->
    url = {}
    url.group = json.group if json.group
    url.uri = json.value
    url

  parse_class = (json) ->
    klass = {}
    klass.group = json.group if json.group
    klass.name = json.value.toLowerCase()
    klass

  parse_key = (json) ->
    key = {}
    key.group = json.group if json.group
    if json.params
      for k,v of json.params
        key.params || key.params = {}
        key.params[k] = v if k.match(/value|encoding|type/i)
    key.value = json.value
    key

  #generate functions
  generate_fn = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "FN"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.name}\r\n"
    string
  
  generate_n = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "N"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += if json.families then ":#{json.families.join(',')};" else ":;" 
    string += if json.givens then "#{json.givens.join(',')};" else ";" 
    string += if json.middles then "#{json.middles.join(',')};" else ";"
    string += if json.prefixes then "#{json.prefixes.join(',')};" else ";"
    string += if json.suffixes then "#{json.suffixes.join(',')}\r\n" else "\r\n"
    string

  generate_nickname = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "NICKNAME"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.names.join(',')}\r\n"
    string

  generate_photo = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "PHOTO"
    if json.params
      for k,v of json.params
        if k.match(/value|encoding|type/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.image}\r\n"
    string

  generate_bday = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "BDAY"
    if json.params
      for k,v of json.params
        if k.match(/value/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.year}-#{json.month}-#{json.day}"
    string += "T#{json.hour}:#{json.minute}:#{json.second}Z" if json.params && json.params.value && (json.params.value == "date-time")
    string += "\r\n"
    string

  generate_adr = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "ADR"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
        if k.match(/types/)
          string += ";TYPE=#{v.join(',').toUpperCase()}"
    if json.pobox then (string += ":#{json.pobox};") else (string += ":;")
    if json.extended then (string += "#{json.extended};") else (string += ";")
    if json.street then (string += "#{json.street};") else (string += ";")
    if json.locality then (string += "#{json.locality};") else (string += ";")
    if json.region then (string += "#{json.region};") else (string += ";")
    if json.code then (string += "#{json.code};") else (string += ";")
    if json.country then (string += "#{json.country}\r\n") else (string += "\r\n")
    string

  generate_label = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "LABEL"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
        if k.match(/types/)
          string += ";TYPE=#{v.join(',').toUpperCase()}"
    string += ":#{json.address}\r\n"
    string

  generate_tel = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "TEL"
    if json.params
      for k,v of json.params
        if k.match(/types/)
          string += ";TYPE=#{v.join(',').toUpperCase()}"
    string += ":#{json.number}\r\n"
    string

  generate_email = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "EMAIL"
    if json.params
      for k,v of json.params
        if k.match(/types/)
          string += ";TYPE=#{v.join(',').toUpperCase()}"
    string += ":#{json.address}\r\n"
    string

  generate_mailer = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "MAILER"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.name}\r\n"
    string

  generate_tz = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "TZ"
    if json.params
      for k,v of json.params
        if k.match(/value/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.zone}"
    string += "\r\n"
    string

  generate_geo = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "GEO"
    string += ":#{json.latitude};#{json.longitude}\r\n"
    string

  generate_title = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "TITLE"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.name}\r\n"
    string

  generate_role = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "ROLE"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.name}\r\n"
    string

  generate_logo = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "LOGO"
    if json.params
      for k,v of json.params
        if k.match(/value|encoding|type/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.image}\r\n"
    string

  generate_org = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "ORG"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.name}"
    string += ";#{json.unit}"
    string += ";#{json.unit2}"
    string += "\r\n"
    string
  
  generate_categories = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "CATEGORIES"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.names.join(',')}\r\n"
    string

  generate_note = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "NOTE"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.description}\r\n"
    string

  generate_prodid = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "PRODID"
    string += ":#{json.id}\r\n"
    string

  generate_rev = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "REV"
    if json.params
      for k,v of json.params
        if k.match(/value/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.year}-#{json.month}-#{json.day}"
    string += "T#{json.hour}:#{json.minute}:#{json.second}Z" if json.hour && json.minute && json.second
    string += "\r\n"
    string

  generate_sort_string = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "SORT-STRING"
    if json.params
      for k,v of json.params
        if k.match(/value|language|x-\w+/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.name}\r\n"
    string

  generate_sound = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "SOUND"
    if json.params
      for k,v of json.params
        if k.match(/value|encoding|type/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.value}\r\n"
    string

  generate_uid = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "UID"
    if json.params
      for k,v of json.params
        if k.match(/type/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.id}\r\n"
    string

  generate_url = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "URL"
    string += ":#{json.uri}\r\n"
    string

  generate_class = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "CLASS"
    string += ":#{json.name.toUpperCase()}\r\n"
    string

  generate_key = (json) ->
    string = ""
    if json.group
      string += "#{json.group}."
    string += "KEY"
    if json.params
      for k,v of json.params
        if k.match(/value|encoding|type/i)
          string += ";#{k.toUpperCase()}=#{v.toUpperCase()}"
    string += ":#{json.value}\r\n"
    string
  m
)()
