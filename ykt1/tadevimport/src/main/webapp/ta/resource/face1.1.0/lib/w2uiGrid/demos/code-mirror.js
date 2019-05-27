// ------
// Init Code Mirror mixed HTML in one command

$(function () {
    $('head').append(
        '<!-- CODE MIRROR -->\n'+
        '<link rel="stylesheet" href="code-mirror.css">\n'+
        '<script src="./CodeMirror/lib/codemirror.js"></script>\n'+
        '<script src="./CodeMirror/mode/javascript/javascript.js"></script>\n'+
        '<script src="./CodeMirror/mode/htmlmixed/htmlmixed.js"></script>\n'+
        '<script src="./CodeMirror/mode/css/css.js"></script>\n'+
        '<script src="./CodeMirror/mode/xml/xml.js"></script>\n'
    );
});