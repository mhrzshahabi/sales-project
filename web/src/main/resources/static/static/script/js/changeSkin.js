function initialButtons () {
        var nicico = isc.getCurrentSkin().name == 'Nicico'? true: false;

        if(!nicico){
            isc.ClassFactory.defineClass("ToolStripButtonAdd", "Button").addProperties({
                baseStyle: "toolStripButton",
                autoFit: true,
                icon: "[SKIN]/actions/add.png",
            });
            isc.ClassFactory.defineClass("ToolStripButtonRemove", "Button").addProperties({
                baseStyle: "toolStripButton",
                autoFit: true,
                icon: "[SKIN]/actions/remove.png",
            });
            isc.ClassFactory.defineClass("ToolStripButtonEdit", "Button").addProperties({
                baseStyle: "toolStripButton",
                autoFit: true,
                icon: "[SKIN]/actions/edit.png",
            });
            isc.ClassFactory.defineClass("ToolStripButtonRefresh", "Button").addProperties({
                baseStyle: "toolStripButton",
                autoFit: true,
                icon: "[SKIN]/actions/refresh.png",
            });
            isc.ClassFactory.defineClass("ToolStripButtonExcel", "Button").addProperties({
                baseStyle: "toolStripButton",
                autoFit: true,
                icon: "[SKIN]/actions/excel.png",
            });
            isc.ClassFactory.defineClass("IButtonClose", "Button").addProperties({baseStyle: "toolStripButton"});
        }
}
initialButtons()

function getSearchParameters() {
    var prmstr = window.location.search.substr(1);
    return prmstr != null && prmstr != "" ? transformToAssocArray(prmstr) : {};
}

function transformToAssocArray( prmstr ) {
    var params = {};
    var prmarr = prmstr.split("&");
    for ( var i = 0; i < prmarr.length; i++) {
        var tmparr = prmarr[i].split("=");
        params[tmparr[0]] = tmparr[1];
    }
    return params;
}

function change_fontFace(){
    var newStyle = document.createElement('style');
    console.log(getSearchParameters())
    if(Object.keys(getSearchParameters()).length == 0 || getSearchParameters().lang == 'fa'){
        console.log(getSearchParameters())
        newStyle.appendChild(document.createTextNode("\
@font-face {\
    font-family: BYekan ;\
        src: local('☺'), url('./static/font/BYekan.woff') format('woff'), url('./static/font/BYekan.otf') format('opentype'), url('./static/font/BYekan.ttf') format('truetype');\
}\
"));
    }else {
        newStyle.appendChild(document.createTextNode("\
@font-face {\
    font-family: BYekan ;\
    src: local('☺'), url('./static/font/TimesNewRoman.woff2') format('woff2'), url('./static/font/TimesNewRoman.woff') format('woff'), url('./static/font/TimesNewRoman.otf') format('opentype'), url('./static/font/TimesNewRoman.ttf') format('truetype');\
}\
"));
        var head  = document.getElementsByTagName('head')[0];
        var link  = document.createElement('link');
        link.rel  = 'stylesheet';
        link.type = 'text/css';
        link.href = '/sales/static/css/changeLang.css';
        link.media = 'all';
        head.appendChild(link);

    }
    document.head.appendChild(newStyle);
}

change_fontFace()

