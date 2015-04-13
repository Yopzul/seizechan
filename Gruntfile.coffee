module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      client:
        expand: yes
        cwd: 'views/scripts'
        src: ['*.coffee', '*/*.coffee']
        dest: 'public/scripts'
        ext: '.js'

    jade:
      release:
        options:
          pretty: yes
          data:
            debug: no
        files:
          'public/index.html': 'views/index.jade'
          'public/templates/posts/index.html': 'views/templates/posts/index.jade'

    stylus:
      compile:
        options:
          paths: ['views/styles']
        files:
          'public/styles/style.css': 'views/styles/*.styl'

    clean:
      options:
        force: yes
      client: ['public/*.html', 'public/scripts/*.js', 'public/styles/*.css']


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'compile', ['coffee', 'jade', 'stylus']
