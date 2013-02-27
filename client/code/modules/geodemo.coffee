module.exports = (ng) ->

  ng.controller 'GeoDemoCtrl', [
    '$scope',
    ($scope) ->
      $scope.$on 'ss-geodemo', (event, count,temperature,ldr,batery) ->
        $scope.battery = battery
  ]
