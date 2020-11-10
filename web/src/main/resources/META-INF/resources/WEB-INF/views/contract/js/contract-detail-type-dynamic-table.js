// <%@ page contentType="text/html;charset=UTF-8" %>
// <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
//     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
//     <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
contractDetailTypeTab.toolStrip.param = contractDetailTypeTab.listGrid.param
    .gridComponents
    .find(_ => _.className && _.className.toLowerCase() === 'toolStrip'.toLowerCase())
if (!contractDetailTypeTab.toolStrip.param) throw 'یا خدا';
contractDetailTypeTab.Vars={
    DataType:JSON.parse('${Enum_DataType}')
}
contractDetailTypeTab.method.getAllFields=function(_object){
    dbg(_object)
    if (typeof (_object) !== 'object') return [_object];
    const fields = Object.keys(_object).filter(_=>!_.toString().startsWith('_')&&!_.toString().startsWith('$')).filter(_=>typeof _object[_] !== 'object');
    const internalObj = Object.keys(_object).filter(_=>!_.toString().startsWith('_')&&!_.toString().startsWith('$')).filter(_=>typeof _object[_] === 'object');
    internalObj.forEach(_=>fields.addList(contractDetailTypeTab.method.getAllFields(_object[_]).map(__=>_+'.'+__)))
    return fields;
}

contractDetailTypeTab.Fields = {
    DynamicTable: () =>{

        const fields = [
        {
            name: 'id',
            title: "<spring:message code='global.id'/>",
            hidden: true
        },
        {
            name: 'colNum',
            type: "number",
            width: "5%",
            required: true,
            validateOnExit: true,
            title: "<spring:message code='global.col.num'/>",
        },
        {
            name: 'cdtpId',
            hidden: true
        },
        {
            name: 'headerType',

            editorProperties:{
                editorType: "comboBox",
                addUnknownValues:false,
                textMatchStyle:"substring",
                required: true,
                validateOnExit: true,
            },
            type: "string",
            title: "<spring:message code='global.type'/> <spring:message code='global.header'/> ",
            async editorExit (editCompletionEvent, record, newValue, rowNum, colNum){
                if(!newValue)return true;
                const grid = contractDetailTypeTab.listGrid.dynamicTable;
                grid.setEditValue(rowNum, colNum + 1,'')
                grid.setEditValue(rowNum, colNum + 2,'')
                const headerValueField = grid.getField("headerValue")
                const headerKeyField = grid.getField("headerKey")
                // dbg(this)
                if(Object.values(contractDetailTypeTab.Vars.DataType).includes(newValue)){
                    delete headerValueField['editorProperties']
                    delete headerKeyField['editorProperties']
                    // headerKeyField.canEdit=false;
                    // headerKeyField.required=false;
                    headerKeyField.required=false;
                    // headerKeyField.validateOnChange=true;
                    headerValueField.type=newValue
                    headerValueField.canEdit=true
                }
                else {
                    const dialog= isc.Dialog.create({isModal:true,
                        message:"<spring:message code='global.please.wait'/>"})
                    const r = await fetch('${contextPath}'+newValue+'?_startRow=0&_endRow=1',{headers:SalesConfigs.httpHeaders})
                        const response =await  r.json();
                            dialog.destroy();
                            if(r.ok){
                                if(response && response.response && response.response.data && response.response.data.length>0){
                                    const fields = Object.keys(response.response.data[0])
                                        .filter(_=>typeof (response.response.data[0][_])!== 'object').map(_=>{return {name:_}});
                                    const allFields = contractDetailTypeTab.method.getAllFields(response.response.data[0]);
                                    dbg(allFields)
                                    const valueMap = {};
                                    allFields
                                        .forEach(_=>valueMap[_]=_)
                                    // dbg(valueMap)
                                    headerKeyField.required=true;
                                    headerKeyField.validateOnChange=true;
                                    headerKeyField.editorProperties ={
                                        canEdit:true,
                                        required:true,
                                        valueMap:valueMap,
                                        editorType: "comboBox",
                                        validateOnExit:true,
                                        validateOnChange:true,
                                        addUnknownValues:false,
                                        textMatchStyle:"substring",
                                    };
                                    headerValueField.editorProperties ={
                                        optionDataSource : isc.MyRestDataSource.create({
                                            fields:fields,
                                            fetchDataURL:'${contextPath}'+newValue
                                        }),
                                        valueField:fields.find(_=>Object.values(_).includes('id'))?"id":"tozinId",
                                        pickListWidth: .7*innerWidth,
                                        pickListHeight: 800,
                                        pickListFields:fields,
                                        editorType: "SelectItem",
                                        pickListProperties:{
                                            showFilterEditor:true,
                                            allowAdvancedCriteria:true,
                                        }

                                    }
                                }
                            }
                }
                // grid.startEditing(rowNum, colNum+1)
                return true

            }
        },
        {name: 'headerKey',

                title: "<spring:message code='global.key'/> <spring:message code='global.header'/> ",
            },
        {
            name: 'headerValue',
            required: true,
            validateOnExit: true,
            type: "string",
            title: "<spring:message code='contractPenalty.value'/> <spring:message code='global.header'/> ",
        },
        {
            name: 'valueType',
            required: true,
            editorProperties:{
                editorType: "comboBox",
                addUnknownValues:false,
                textMatchStyle:"substring",
                required: true,
                validateOnExit: true,
            },
            validateOnExit: true,
            type: "string",
            title: "<spring:message code='contractPenalty.value'/> <spring:message code='global.type'/> ",
        },
        {
            name: 'required',
            type: 'boolean',
            title: "<spring:message code='global.required'/>",
        },
        {
            name: 'regexValidator',
            type: "string",
            title: "<spring:message code='validator.regex'/>",
        },
        {
            name: 'defaultValue',
            type: "string",
            title: "<spring:message code='global.default-value'/>",
        },
        {
            name: 'maxRows',
            type: "number",
            title: "<spring:message code='MaterialFeature.maxValue'/> <spring:message code='global.row.num'/>",
        },
        {
            name: 'description',
            type: "string",
            editorProperties: {
                type:"textArea"
            },
            title: "<spring:message code='global.description'/>",
        },
        {
            name: 'initialCriteria',
            type: "string",
            editorProperties: {
                type:"textArea"
            },
            width:"20%",
            title: "<spring:message code='global.form.filter'/>",
        },
    ]
        fetch('api/g-contract/entities',{headers:SalesConfigs.httpHeaders}).then(
            res=>{
                res.json().then(response=>{
                    const valueMap = [...Object.values(contractDetailTypeTab.Vars.DataType)
                        .filter(_=>![contractDetailTypeTab.Vars.DataType.DynamicTable,
                        contractDetailTypeTab.Vars.DataType.Reference,
                        contractDetailTypeTab.Vars.DataType.ListOfReference].contains(_))].sort()
                    if(res.ok){
                        valueMap.addList(response.sort());
                    }
                    fields.filter(_=>["headerType","valueType"].contains(_.name)).forEach(_=>_['valueMap']=[...valueMap])
                })
            }
        )

    return fields;
    }
}
contractDetailTypeTab.ToolStripButtons = {DynamicTable:{}};
contractDetailTypeTab.ToolStripButtons.DynamicTable.Define={
        // icon: "pieces/16/icon_add.png",
        title: "<spring:message code='contract-detail-type.window.dynamic-table.define'/>",
        click: function () {
            const _record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
            if(!_record || !_record.type || _record.type !== contractDetailTypeTab.dynamicForm.paramFields.type.valueMap.DynamicTable)
                return isc.warn("<spring:message code='contract-detail-type.window.type-must-dynamic-table'/>")
            contractDetailTypeTab.window.DynamicTable = isc.Window.create({
                title: "<spring:message code='contact.title'/>",
                width: .9 * innerWidth,
                height: 580,
                autoSize: true,
                autoCenter: true,
                isModal: true,
                showModalMask: true,
                align: "center",
                autoDraw: true,
                dismissOnEscape: true,

                closeClick: function () {
                    this.Super("closeClick", arguments)
                },
                members: [
                    contractDetailTypeTab.listGrid.dynamicTable = isc.ListGrid.create({
                        height: "100%",
                        canEdit: true,
                        validateByCell: true,
                        validateOnExit: true,
                        canRemoveRecords:true,
                        editByCell:true,
                        gridComponents: ["filterEditor", "header",
                            "body", "summaryRow",
                            isc.ToolStrip.create({
                                members: [
                                    isc.ToolStripButtonAdd.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.NewColumn),
                                    isc.ToolStripButtonAdd.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.Save),
                                    isc.ToolStripButtonRemove.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.Close),
                                    ]
                            })
                        ],
                        fields: [
                            ...contractDetailTypeTab.Fields.DynamicTable()
                        ]
                    })]
            });
            if(_record.dynamicTables) contractDetailTypeTab.listGrid.dynamicTable.setData(_record.dynamicTables)
            // contractDetailTypeTab.listGrid.dynamicTable.startEditingNew([{colNum:1}])
        }
    };
contractDetailTypeTab.ToolStripButtons.DynamicTable.NewColumn={
            title: "<spring:message code='global.col'/> <spring:message code='global.new'/> ",
            click() {
                contractDetailTypeTab.listGrid.dynamicTable.startEditingNew(
                    {colNum:contractDetailTypeTab.listGrid.dynamicTable.getTotalRows() + 1,
                        maxRows:0,
                        initialCriteria:JSON.stringify({
                            _constructor: "AdvancedCriteria",
                            operator:"and",
                            criteria:[
                                {fieldName:"id",operator: "greaterThan",value:0}
                            ]
                        }),
                    headerType:contractDetailTypeTab.Vars.DataType.String,
                    valueType:contractDetailTypeTab.Vars.DataType.String,
                    })
            }
        };
contractDetailTypeTab.ToolStripButtons.DynamicTable.Save={
            title: "<spring:message code='global.form.save'/>" ,
            icon: "[SKIN]/actions/save.png",
            click() {
                for (let i=0;i<contractDetailTypeTab.listGrid.dynamicTable.getTotalRows();i++)
                {
                    if (!contractDetailTypeTab.listGrid.dynamicTable.validateRow(i)) return;
                }
                contractDetailTypeTab.listGrid.dynamicTable.saveAllEdits();
                const _data = contractDetailTypeTab.listGrid.dynamicTable.getData();
                contractDetailTypeTab.listGrid.param.getSelectedRecord()['dynamicTables']=_data;
                contractDetailTypeTab.window.DynamicTable.destroy()
            }
        };
contractDetailTypeTab.ToolStripButtons.DynamicTable.Close={
            title: "<spring:message code='global.close'/>" ,
            // icon: "[SKIN]/actions/save.png",
            click() {
                contractDetailTypeTab.window.DynamicTable.destroy()
            }
        };
contractDetailTypeTab.toolStrip.param.addMember(
    isc.ToolStripButton.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.Define), 3
)
