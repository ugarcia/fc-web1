module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    less:
      css:
        options:
          strictUnits: true
        src:  'app/**/*.less'
        dest: 'app/css/styles.css'
    
    myth:
      css:
        src:  'app/css/styles.css'
        dest: 'app/css/styles.css'

    cssmin:
      css:
        files:
          'app/css/styles.css': ['app/css/styles.css']

    watch:
      less:
        files: ['app/**/*.less']
        tasks: ['css']
      coffee:
        files: ['app/**/*.coffee']
        tasks: ['js']

    coffee:
      app:
        expand: true
        flatten: false
        cwd: 'app/coffee/'
        src: ['**/*.coffee']
        dest: 'app/js/'
        ext: '.js'
      main:
        expand: true
        flatten: false
        cwd: 'app/modules/main/coffee/'
        src: ['**/*.coffee']
        dest: 'app/modules/main/js/'
        ext: '.js'
      cms:
        expand: true
        flatten: false
        cwd: 'app/modules/cms/coffee/'
        src: ['**/*.coffee']
        dest: 'app/modules/cms/js/'
        ext: '.js'

    requirejs:
      compile:
        options:
          appDir: "app"
          baseUrl: "."
          dir: "./build"
          modules: [
              {
                  name: "app/js/startup"
              }
          ]
          removeCombined: true
          preserveLicenseComments: false
          paths:
            modernizr: 'bower_components/modernizr/modernizr'
            jquery: "bower_components/jquery/dist/jquery.min"
            bootstrap: "bower_components/bootstrap/dist/js/bootstrap.min"
            underscore: "bower_components/underscore/underscore"
            backbone: 'bower_components/backbone/backbone'
            marionette: 'bower_components/marionette/lib/backbone.marionette.min'
            tpl: 'bower_components/requirejs-tpl/tpl'
            app: 'app'
          shim:
            bootstrap:
              deps: ['jquery']
            underscore:
              exports: '_'
            backbone:
              deps: ["underscore", "jquery"]
              exports: "Backbone"
            marionette:
              deps: ["backbone"]
              exports: "Marionette"
            
    copy:
      build:
        files: [
          {
            src:  [
              'bower_components/bootstrap/dist/css/**'
              'bower_components/bootstrap/dist/fonts/**'
            ]
            dest: 'build/'
            expand:  true
          }
        ]

    clean:
      build: 'build'
      requirelog: 'build/build.txt'

    uglify:
      options:
        compress:
          drop_console: true
        mangle: false
      build:
        files:
          'build/bower_components/requirejs/require.js': ['bower_components/requirejs/require.js']

    htmlmin:
      build:
        options:
          removeComments: true
          collapseWhitespace: true
        expand: true
        cwd:  'build'
        src: ['**/*.html']
        dest: 'build/'


  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-myth'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-htmlmin'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'

  grunt.registerTask 'default', [
    'css'
    'js'
  ]

  grunt.registerTask 'css', [
    'less:css'
    'myth:css'
    'cssmin:css'
  ]

  grunt.registerTask 'js', [
    'coffee:app'
    'coffee:main'
    'coffee:cms'
  ]

  grunt.registerTask 'build', [
    'clean:build'
    'default'
    'requirejs:compile'
    'copy:build'
    'uglify:build'
    'htmlmin:build'
    'clean:requirelog'
  ]