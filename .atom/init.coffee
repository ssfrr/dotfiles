# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-workspace', 'custom:save-and-close', ->
    pane = atom.workspace.getActivePane()
    editor = pane.getActiveItem()
    # assume the active text editor is the active item of the active pane?
    if editor.getPath()
        editor.save()
    else
        savePath = atom.showSaveDialogSync()
        editor.saveAs(savePath)
    editor.destroy()
