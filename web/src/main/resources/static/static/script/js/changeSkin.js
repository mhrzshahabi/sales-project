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

