# Admin module definitions

# FIXME: need better way to store briqs and installed items, the current
#   approach requires extremely much "data navigation" code and logic :(
# would much better to load rows as instances with extra behavior

# A "briq" is a module which can be installed in the application.
# Doing so creates a "briq object", or "bob", which does the real work.
#
# briqs:
#   id = unique id
#   key = filename
#   info: object from exports, i.e. description, inputs, etc
#
# bobs:
#   id = unique id
#   key = briqname:and:args
#   briq_id: parent briq
#   more... config settings for this installed instance?

module.exports = (ng) ->

  ng.controller 'AdminCtrl', [
    '$scope','rpc',
    ($scope, rpc) ->

      $scope.collection 'bobs'
      
      $scope.selectBriq = (obj) ->
        # if there are no args, it may already have been installed
        if bob = $scope.bobs?.find obj.info.name
          $scope.selectBob bob
        else
          $scope.bob = null
          $scope.briq = obj
          # TODO candidate for a Briq method
          for input in obj.info.inputs or []
            input.value = null
      
      $scope.createBob = ->
        # TODO candidate for a Briq method
        keyList = [$scope.briq.info.name]
        for input in $scope.briq.info.inputs or []
          keyList.push input.value?.keys or input.value or input.default
        key = keyList.join(':')

        $scope.bobs.store
          briq_id: $scope.briq.id
          key: key

      $scope.selectBob = (obj) ->
        $scope.bob = obj
        $scope.briq = $scope.briqs.byId[obj.briq_id]

        # TODO candidate for a Briq method
        keys = obj.key.split(':').slice 1
        for input in $scope.briq.info.inputs or []
          input.value = keys.shift()

      $scope.removeBob = ->
        $scope.bobs.store _.omit $scope.bob, 'key'
        $scope.bob = null
        $scope.briq = null
  ]
