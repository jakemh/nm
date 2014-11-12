angular.module("NM").directive "editableToggle", ->
  template: 
    ''' 
    <a href ng-if=true editable-text={{attr}}>  
      {{attrEval || default}}
    </a>
    <span ng-if=false>{{attrEval}}</span>

    '''

  scope:
    default: "@default"
    attr: "@attr"
    attrEval: "&attr"

    toggle: "@toggle"