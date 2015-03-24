describe 'angular-klaxon', ->
  beforeEach module 'klaxon'

  beforeEach inject (KlaxonAlert) ->
    # clear alerts between each test run
    KlaxonAlert.all = []

  beforeEach inject ($rootScope, $compile) ->
    @$scope = $rootScope.$new()
    @compileAndRender = (html) =>
      el = $compile(html)(@$scope)
      @$scope.$digest()
      $(document.body).empty().append el
      el

  describe 'KlaxonAlert service', ->
    it 'should create a new alert', inject (KlaxonAlert) ->
      alert = new KlaxonAlert('The floor is lava!', type: 'danger')
      expect(alert.msg).to.equal 'The floor is lava!'
      expect(alert.type).to.equal 'danger'

  describe '<klaxon-alert> directive', ->
    it 'should have a close button by default', inject (KlaxonAlert) ->
      @$scope.alert = new KlaxonAlert('The floor is lava!')
      el = @compileAndRender('<klaxon-alert data="alert"></klaxon-alert>')
      expect(el.find 'button.close').to.be.visible

    it 'should hide the close button on request', inject (KlaxonAlert) ->
      @$scope.alert = new KlaxonAlert('The floor is lava!', closable: false)
      el = @compileAndRender('<klaxon-alert data="alert"></klaxon-alert>')
      expect(el.find 'button.close').not.to.be.visible

  describe '<klaxon-alert-container> directive', ->
    it 'should render the alert container with all the alerts added', inject (KlaxonAlert) ->
      new KlaxonAlert('The floor is lava!').add()
      new KlaxonAlert('Safe!').add()
      el = @compileAndRender '<klaxon-alert-container></klaxon-alert-container>'
      expect(el).to.contain 'The floor is lava!'
      expect(el).to.contain 'Safe!'
