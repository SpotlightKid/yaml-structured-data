
# Strukturierte Daten mit YAML

> https://github.com/SpotlightKid/yaml-structured-data.git

YAML: YAML Ain't Markup Language

http://yaml.org/

Python Library: PyYAML
    
http://pyyaml.org/

## PyYAML installieren

```
$ pip install PyYAML
```

## Module importieren


    import yaml
    from collections import namedtuple
    from IPython.lib.pretty import pprint

## Daten einlesen


    with open('movies.yml') as fp:
        yamldata = fp.read()
    
    print(yamldata)

    -
      title: Der Blade Runner
      original: Blade Runner
      director: Ridley Scott
      year: 1982
      url: http://www.imdb.com/title/tt0083658
    - title: Der Wüstenplanet
      original: Dune
      director: David Lynch
      year: 1984
      url: http://www.imdb.com/title/tt0087182
    - title: Terminator
      original: The Terminator
      director: James Cameron
      year: 1984
      url: http://www.imdb.com/title/tt0088247
    


## De-Serialisierung


    
    moviedata = yaml.load(yamldata)
    pprint(moviedata)


    [{'director': 'Ridley Scott',
      'original': 'Blade Runner',
      'title': 'Der Blade Runner',
      'url': 'http://www.imdb.com/title/tt0083658',
      'year': 1982},
     {'director': 'David Lynch',
      'original': 'Dune',
      'title': 'Der Wüstenplanet',
      'url': 'http://www.imdb.com/title/tt0087182',
      'year': 1984},
     {'director': 'James Cameron',
      'original': 'The Terminator',
      'title': 'Terminator',
      'url': 'http://www.imdb.com/title/tt0088247',
      'year': 1984}]


## Objekt-Mapping


    fields = moviedata[0].keys()
    Movie = namedtuple('Movie', fields)
    movies = [Movie(**data) for data in moviedata]
    pprint(movies)

    [Movie(year=1982, url='http://www.imdb.com/title/tt0083658', original='Blade Runner', director='Ridley Scott', title='Der Blade Runner'),
     Movie(year=1984, url='http://www.imdb.com/title/tt0087182', original='Dune', director='David Lynch', title='Der Wüstenplanet'),
     Movie(year=1984, url='http://www.imdb.com/title/tt0088247', original='The Terminator', director='James Cameron', title='Terminator')]


## Benutzung


    print(movies[1].director)
    
    movies.append(Movie(title="Star Wars", original="Star Wars", year=1977,
                        director="George Lucas",
                        url="http://www.imdb.com/title/tt0076759/"))
    
    print(movies[-1].url)


    David Lynch
    http://www.imdb.com/title/tt0076759/


## Serialisierung

### Erster Versuch


    yamldata = yaml.dump(movies)
    print(yamldata)
    isinstance(yaml.load(yamldata)[0], Movie)

    - !!python/object/new:__main__.Movie [1982, 'http://www.imdb.com/title/tt0083658',
      Blade Runner, Ridley Scott, Der Blade Runner]
    - !!python/object/new:__main__.Movie [1984, 'http://www.imdb.com/title/tt0087182',
      Dune, David Lynch, "Der W\xFCstenplanet"]
    - !!python/object/new:__main__.Movie [1984, 'http://www.imdb.com/title/tt0088247',
      The Terminator, James Cameron, Terminator]
    - !!python/object/new:__main__.Movie [1977, 'http://www.imdb.com/title/tt0076759/',
      Star Wars, George Lucas, Star Wars]
    





    True



### Zweiter Versuch


    yamldata = yaml.dump([dict(zip(fields, m)) for m in movies])
    print(yamldata)

    - {director: Ridley Scott, original: Blade Runner, title: Der Blade Runner, url: 'http://www.imdb.com/title/tt0083658',
      year: 1982}
    - {director: David Lynch, original: Dune, title: "Der W\xFCstenplanet", url: 'http://www.imdb.com/title/tt0087182',
      year: 1984}
    - {director: James Cameron, original: The Terminator, title: Terminator, url: 'http://www.imdb.com/title/tt0088247',
      year: 1984}
    - {director: George Lucas, original: Star Wars, title: Star Wars, url: 'http://www.imdb.com/title/tt0076759/',
      year: 1977}
    


### Dritter Versuch


    yamldata = yaml.dump([dict(zip(fields, m)) for m in movies],
                         default_flow_style=False)
    print(yamldata)

    - director: Ridley Scott
      original: Blade Runner
      title: Der Blade Runner
      url: http://www.imdb.com/title/tt0083658
      year: 1982
    - director: David Lynch
      original: Dune
      title: "Der W\xFCstenplanet"
      url: http://www.imdb.com/title/tt0087182
      year: 1984
    - director: James Cameron
      original: The Terminator
      title: Terminator
      url: http://www.imdb.com/title/tt0088247
      year: 1984
    - director: George Lucas
      original: Star Wars
      title: Star Wars
      url: http://www.imdb.com/title/tt0076759/
      year: 1977
    


## Pro

* Leicht les- *und* schreibbares Textformat für Datensätze, z.B. als Ersatz für CSV
* Automatische Typerkennung
* (De-)Serialisierung leicht erweiterbar

## Contra

* Non-Standard-Library Modul
* Relativ langsam (z.B. nicht als Messaging-Format geeignet)
* Serialisierung etwas un-intuitiv
* Namedtuple: keine Default-Werte für fehlende Datenfelder 

## Fragen?

> https://github.com/SpotlightKid/yaml-structured-data

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Strukturierte Daten mit YAML</span> von <a xmlns:cc="http://creativecommons.org/ns#" href="http://chrisarndt.de/" property="cc:attributionName" rel="cc:attributionURL">Christopher Arndt</a> ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 4.0 International Lizenz</a>.

