describe("Vcard", function() {

  var vcard, fn, fn_string, n, n_string, nickname, nickname_string, photo, photo_string, bday, bday_string, adr, adr_string, label, label_string, tel, tel_string, email, email_string, mailer, mailer_string, tz, tz_string, geo, geo_string, title, title_string, role, role, string, logo, logo_string, org, org_string, categories, categories_string, note, note_string, prodid, prodid_string, rev, rev_string, sort_string, sort_string_string, sound, sound_string, uid, uid_string, url, url_string, version, version_string, klass, klass_string, key, key_string;

  beforeEach(function() {
    vcard = VCARD;  
    fn = {"version" : "3.0", "fn": {"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "name" : "Andrew Pace"}};
    fn_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.FN;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Andrew Pace\r\nEND:VCARD";

    n = {"version" : "3.0", "n": {"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "givens" : ["Andrew"], "middles" : ["Patrick"], "families" : ["Pace"], "prefixes" : ["Mr", "Dr"], "suffixes" : ["MD"]}};
    n_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.N;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Pace;Andrew;Patrick;Mr,Dr;MD\r\nEND:VCARD";

    nickname = {"version" : "3.0", "nickname": {"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "names" : ["Andy", "Drew"]}};
    nickname_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.NICKNAME;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Andy,Drew\r\nEND:VCARD";

    photo = {"version" : "3.0", "photos" : [{"group" : "item1", "params" : {"value" : "binary", "encoding" : "b", "type" : "jpg"}, "image" : "abcdefg=="}]};
    photo_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.PHOTO;VALUE=BINARY;ENCODING=B;TYPE=JPG:abcdefg==\r\nEND:VCARD";

    bday = {"version" : "3.0", "bday": {"group" : "item1", "params" : {"value" : "date"}, "year" : "1982", "month" : "08", "day" : "30"}};
    bday_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.BDAY;VALUE=DATE:1982-08-30\r\nEND:VCARD";

    adr = {"version" : "3.0", "adrs": [{"group" : "item1", "params" : {"types" : ["home", "work"]}, "street" : "1004 Westmont Dr", "locality" : "Alhambra", "region" : "CA", "code" : "91803", "country" : "USA"}]};
    adr_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.ADR;TYPE=HOME,WORK:;;1004 Westmont Dr;Alhambra;CA;91803;USA\r\nEND:VCARD";

    label = {"version" : "3.0", "labels": [{"group" : "item1", "params" : {"types" : ["home", "work"]}, "address" : "1004 Westmont Dr\nAlhambra, CA\n91803\nUSA"}]};
    label_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.LABEL;TYPE=HOME,WORK:1004 Westmont Dr\nAlhambra, CA\n91803\nUSA\r\nEND:VCARD";

    tel = {"version" : "3.0", "tels": [{"group" : "item1", "params" : {"types" : ["home", "work"]}, "number" : "+1-323-243-7314"}]};
    tel_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.TEL;TYPE=HOME,WORK:+1-323-243-7314\r\nEND:VCARD";

    email = {"version" : "3.0", "emails": [{"group" : "item1", "params" : {"types" : ["home", "work"]}, "address" : "andrewppace@gmail.com"}]};
    email_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.EMAIL;TYPE=HOME,WORK:andrewppace@gmail.com\r\nEND:VCARD";

    mailer = {"version" : "3.0", "mailer": {"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "name" : "Evolution 3.0"}};
    mailer_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.MAILER;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Evolution 3.0\r\nEND:VCARD";

    tz = {"version" : "3.0", "tz": {"group" : "item1", "params" : {"value" : "text"}, "zone" : "-05:00"}};
    tz_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.TZ;VALUE=TEXT:-05:00\r\nEND:VCARD";

    geo = {"version" : "3.0", "geo": {"group" : "item1", "latitude" : "37.386013", "longitude" : "-122.082932"}};
    geo_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.GEO:37.386013;-122.082932\r\nEND:VCARD";
    
    title = {"version" : "3.0", "titles": [{"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "name" : "Resident"}]};
    title_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.TITLE;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Resident\r\nEND:VCARD";
    
    role = {"version" : "3.0", "roles": [{"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "name" : "In training"}]};
    role_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.ROLE;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:In training\r\nEND:VCARD";

    logo = {"version" : "3.0", "logos" : [{"group" : "item1", "params" : {"value" : "binary", "encoding" : "b", "type" : "jpg"}, "image" : "abcdefg=="}]};
    logo_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.LOGO;VALUE=BINARY;ENCODING=B;TYPE=JPG:abcdefg==\r\nEND:VCARD";

    org = {"version" : "3.0", "orgs":[{"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "name" : "USC", "unit" : "Dermatology", "unit2" : "County"}]};
    org_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.ORG;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:USC;Dermatology;County\r\nEND:VCARD";

    categories = {"version" : "3.0", "categories": {"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "names" : ["Resident", "County"]}};
    categories_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.CATEGORIES;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Resident,County\r\nEND:VCARD";

    note = {"version" : "3.0", "notes": [{"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "description" : "We met in high school."}]};
    note_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.NOTE;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:We met in high school.\r\nEND:VCARD";

    prodid = {"version" : "3.0", "prodid": {"group" : "item1", "id" : "123456"}};
    prodid_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.PRODID:123456\r\nEND:VCARD";

    rev = {"version" : "3.0", "rev": {"group" : "item1", "year" : "2012", "month" : "05", "day" : "14", "hour" : "07", "minute" : "04", "second" : "19"}};
    rev_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.REV:2012-05-14T07:04:19Z\r\nEND:VCARD";

    sort_string = {"version" : "3.0", "sort_string": {"group" : "item1", "params" : {"value" : "text", "language" : "en", "x-param" : "value"}, "name" : "Pace"}};
    sort_string_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.SORT-STRING;VALUE=TEXT;LANGUAGE=EN;X-PARAM=VALUE:Pace\r\nEND:VCARD";

    sound = {"version" : "3.0", "sounds" : [{"group" : "item1", "params" : {"value" : "binary", "encoding" : "b", "type" : "mp3"}, "value" : "abcdefg=="}]};
    sound_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.SOUND;VALUE=BINARY;ENCODING=B;TYPE=MP3:abcdefg==\r\nEND:VCARD";
    
    uid = {"version" : "3.0", "uid" : {"group" : "item1", "params" : {"type" : "uuid"}, "id" : "1234567890"}};
    uid_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.UID;TYPE=UUID:1234567890\r\nEND:VCARD";
    
    url = {"version" : "3.0", "urls" : [{"group" : "item1", "uri" : "www.example.com"}]};
    url_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.URL:www.example.com\r\nEND:VCARD";

    version = {"version" : "3.0"}
    version_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nEND:VCARD"
    
    klass = {"version" : "3.0", "classes" : [{"group" : "item1", "name" : "public"}]};
    klass_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.CLASS:PUBLIC\r\nEND:VCARD";

    key = {"version" : "3.0", "key" : {"group" : "item1", "params" : {"value" : "binary", "encoding" : "b", "type" : "pub"}, "value" : "abcdefg=="}};
    key_string = "BEGIN:VCARD\r\nVERSION:3.0\r\nitem1.KEY;VALUE=BINARY;ENCODING=B;TYPE=PUB:abcdefg==\r\nEND:VCARD";
  });

  describe(".generate", function() {

    it("creates an version line", function() {
      expect(vcard.generate(version)).toEqual(version_string);
    });

    it("creates an fn line", function() {
      expect(vcard.generate(fn)).toEqual(fn_string);
    });

    it("creates an n line", function() {
      expect(vcard.generate(n)).toEqual(n_string);
    });

    it("creates a nickname line", function() {
      expect(vcard.generate(nickname)).toEqual(nickname_string);
    });

    it("creates a photo line", function() {
      expect(vcard.generate(photo)).toEqual(photo_string);
    });

    it("creates a bday line", function() {
      expect(vcard.generate(bday)).toEqual(bday_string);
    });

    it("creates an adr line", function() {
      expect(vcard.generate(adr)).toEqual(adr_string);
    });

    it("creates a label line", function() {
      expect(vcard.generate(label)).toEqual(label_string);
    });

    it("creates a tel line", function() {
      expect(vcard.generate(tel)).toEqual(tel_string);
    });

    it("creates an email line", function() {
      expect(vcard.generate(email)).toEqual(email_string);
    });

    it("creates a mailer line", function() {
      expect(vcard.generate(mailer)).toEqual(mailer_string);
    });

    it("creates a tz line", function() {
      expect(vcard.generate(tz)).toEqual(tz_string);
    });

    it("creates a geo line", function() {
      expect(vcard.generate(geo)).toEqual(geo_string);
    });

    it("creates a title line", function() {
      expect(vcard.generate(title)).toEqual(title_string);
    });

    it("creates a role line", function() {
      expect(vcard.generate(role)).toEqual(role_string);
    });

    it("creates a logo line", function() {
      expect(vcard.generate(logo)).toEqual(logo_string);
    });

    it("creates an org line", function() {
      expect(vcard.generate(org)).toEqual(org_string);
    });

    it("creates a categories line", function() {
      expect(vcard.generate(categories)).toEqual(categories_string);
    });

    it("creates a note line", function() {
      expect(vcard.generate(note)).toEqual(note_string);
    });

    it("creates a prodid line", function() {
      expect(vcard.generate(prodid)).toEqual(prodid_string);
    });

    it("creates a rev line", function() {
      expect(vcard.generate(rev)).toEqual(rev_string);
    });

    it("creates a sort-string object", function() {
      expect(vcard.generate(sort_string)).toEqual(sort_string_string);
    });

    it("creates a sound object", function() {
      expect(vcard.generate(sound)).toEqual(sound_string);
    });

    it("creates a uid object", function() {
      expect(vcard.generate(uid)).toEqual(uid_string);
    });

    it("creates a url object", function() {
      expect(vcard.generate(url)).toEqual(url_string);
    });

    it("creates a class object", function() {
      expect(vcard.generate(klass)).toEqual(klass_string);
    });

    it("creates a key object", function() {
      expect(vcard.generate(key)).toEqual(key_string);
    });
  });

  describe(".parse", function() {

    it("creates an version object", function() {
      expect(vcard.parse(version_string)).toEqual(version);
    });

    it("creates an fn object", function() {
      expect(vcard.parse(fn_string)).toEqual(fn);
    });
    
    it("creates an n object", function() {
      expect(vcard.parse(n_string)).toEqual(n);
    });

    it("creates a nickname object", function() {
      expect(vcard.parse(nickname_string)).toEqual(nickname);
    });

    it("creates a photo object", function() {
      expect(vcard.parse(photo_string)).toEqual(photo);
    });

    it("creates a bday object", function() {
      expect(vcard.parse(bday_string)).toEqual(bday);
    });

    it("creates an adr object", function() {
      expect(vcard.parse(adr_string)).toEqual(adr);
    });
    
    it("creates a label object", function() {
      expect(vcard.parse(label_string)).toEqual(label);
    });
    
    it("creates a tel object", function() {
      expect(vcard.parse(tel_string)).toEqual(tel);
    });
    
    it("creates an email object", function() {
      expect(vcard.parse(email_string)).toEqual(email);
    });
    
    it("creates a mailer object", function() {
      expect(vcard.parse(mailer_string)).toEqual(mailer);
    });
    
    it("creates a tz object", function() {
      expect(vcard.parse(tz_string)).toEqual(tz);
    });
    
    it("creates a geo object", function() {
      expect(vcard.parse(geo_string)).toEqual(geo);
    });
    
    it("creates a title object", function() {
      expect(vcard.parse(title_string)).toEqual(title);
    });
    
    it("creates a role object", function() {
      expect(vcard.parse(role_string)).toEqual(role);
    });
    
    it("creates a logo object", function() {
      expect(vcard.parse(logo_string)).toEqual(logo);
    });
    
    it("creates an org object", function() {
      expect(vcard.parse(org_string)).toEqual(org);
    });
    
    it("creates a categories object", function() {
      expect(vcard.parse(categories_string)).toEqual(categories);
    });
    
    it("creates an note object", function() {
      expect(vcard.parse(note_string)).toEqual(note);
    });
    
    it("creates an prodid object", function() {
      expect(vcard.parse(prodid_string)).toEqual(prodid);
    });
    
    it("creates an rev object", function() {
      expect(vcard.parse(rev_string)).toEqual(rev);
    });

    it("creates an sort-string object", function() {
      expect(vcard.parse(sort_string_string)).toEqual(sort_string);
    });

    it("creates an sound object", function() {
      expect(vcard.parse(sound_string)).toEqual(sound);
    });

    it("creates an uid object", function() {
      expect(vcard.parse(uid_string)).toEqual(uid);
    });

    it("creates an url object", function() {
      expect(vcard.parse(url_string)).toEqual(url);
    });

    it("creates an class object", function() {
      expect(vcard.parse(klass_string)).toEqual(klass);
    });

    it("creates an key object", function() {
      expect(vcard.parse(key_string)).toEqual(key);
    });
  });
});
