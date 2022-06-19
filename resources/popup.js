var popup_instance = null;

function create_popup(title, text) {
    if (popup_instance != null) return
    var component = Qt.createComponent(
            "qrc:/resources/qml/InfoPopup.qml")
    var err = component.errorString()
    if (err) console.log(err)
    popup_instance = component.createObject(application, {
        title: title,
        description: text,
    })
    popup_instance.onClosed.connect(function() { popup_instance = null })
    popup_instance.open()
}