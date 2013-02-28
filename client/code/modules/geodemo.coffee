module.exports = (ng) ->

  ng.controller 'GeoDemoCtrl', [
    '$scope',
    ($scope) ->
      $scope.$on 'ss-geodemo', (event, count,temperature,ldr,battery) ->
        $scope.battery = battery
        $scope.temperature = Math.round(temperature*10.0)/10.0
        $scope.ldr = ldr
        $scope.count = count
  ]
