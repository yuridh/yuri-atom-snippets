JsPatternsAtomSnippetsView = require './js-patterns-atom-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = JsPatternsAtomSnippets =
  jsPatternsAtomSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @jsPatternsAtomSnippetsView = new JsPatternsAtomSnippetsView(state.jsPatternsAtomSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @jsPatternsAtomSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'js-patterns-atom-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @jsPatternsAtomSnippetsView.destroy()

  serialize: ->
    jsPatternsAtomSnippetsViewState: @jsPatternsAtomSnippetsView.serialize()

  toggle: ->
    console.log 'JsPatternsAtomSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
