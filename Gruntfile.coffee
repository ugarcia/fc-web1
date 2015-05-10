module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    less:
      css:
        options:
          strictUnits: true
        src:  'less/**/*.less'
        dest: 'css/styles.css'
    
    myth:
      css:
        src:  'css/styles.css'
        dest: 'css/styles.css'

    cssmin:
      css:
        files:
          'css/styles.css': ['css/styles.css']

    watch:
      less:
        files: ['less/**/*.less']
        tasks: ['css']
      coffee:
        files: ['coffee/**/*']
        tasks: ['js']

    coffee:
      compile:
        expand: true
        flatten: false
        cwd: 'coffee/'
        src: ['**/*.coffee']
        dest: 'js/'
        ext: '.js'

    requirejs:
      compile:
        options:
          appDir: "."
          baseUrl: "."
          dir: "./build"
          modules: [
              {
                  name: "js/startup"
              }
          ]
          removeCombined: true
          preserveLicenseComments: false
          paths:
            jquery: "bower_components/jquery/dist/jquery.min"
            bootstrap: "bower_components/bootstrap/dist/js/bootstrap.min"
            underscore: "bower_components/underscore/underscore"
            backbone: 'bower_components/backbone/backbone'
            marionette: 'bower_components/marionette/lib/backbone.marionette.min'
            app: 'js'
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
    'coffee:compile'
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