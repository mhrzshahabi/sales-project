// <%@ page contentType="text/html;charset=UTF-8" %>
// <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
//     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
//     <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
//     <%@ page import="com.nicico.copper.core.SecurityUtil" %>
contractTab.Vars.DataType = JSON.parse('${Enum_DataType}')
contractTab.ToolStripButtons = {DynamicTable: {}};
contractTab.ToolStripButtons.DynamicTable.Define = {
    // icon: "pieces/16/icon_add.png",
    title: "<spring:message code='contract-detail-type.window.dynamic-table.define'/>",
    click: function () {
        // const _record = contractDetailTypeTab.listGrid.param.getSelectedRecord();
        // if(!_record || !_record.type || _record.type !== contractDetailTypeTab.dynamicForm.paramFields.type.valueMap.DynamicTable)
        //     return isc.warn("<spring:message code='contract-detail-type.window.type-must-dynamic-table'/>")
        // contractDetailTypeTab.window.DynamicTable = isc.Window.create({
        //     title: "<spring:message code='contact.title'/>",
        //     width: .9 * innerWidth,
        //     height: 580,
        //     autoSize: true,
        //     autoCenter: true,
        //     isModal: true,
        //     showModalMask: true,
        //     align: "center",
        //     autoDraw: true,
        //     dismissOnEscape: true,
        //
        //     closeClick: function () {
        //         this.Super("closeClick", arguments)
        //     },
        //     members: [
        //         contractDetailTypeTab.listGrid.dynamicTable = isc.ListGrid.create({
        //             height: "100%",
        //             canEdit: true,
        //             validateByCell: true,
        //             validateOnExit: true,
        //             canRemoveRecords:true,
        //             editByCell:true,
        //             gridComponents: ["filterEditor", "header",
        //                 "body", "summaryRow",
        //                 isc.ToolStrip.create({
        //                     members: [
        //                         isc.ToolStripButtonAdd.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.NewColumn),
        //                         isc.ToolStripButtonAdd.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.Save),
        //                         isc.ToolStripButtonRemove.create(contractDetailTypeTab.ToolStripButtons.DynamicTable.Close),
        //                     ]
        //                 })
        //             ],
        //             fields: [
        //                 ...contractDetailTypeTab.Fields.DynamicTable()
        //             ]
        //         })]
        // });
        // if(_record.dynamicTables) contractDetailTypeTab.listGrid.dynamicTable.setData(_record.dynamicTables)
    }
};
contractTab.ToolStripButtons.DynamicTable.Save = {
    title: "<spring:message code='global.form.save'/>",
    icon: "[SKIN]/actions/save.png",
    click() {
        // for (let i=0;i<contractDetailTypeTab.listGrid.dynamicTable.getTotalRows();i++)
        // {
        //     if (!contractDetailTypeTab.listGrid.dynamicTable.validateRow(i)) return;
        // }
        // contractDetailTypeTab.listGrid.dynamicTable.saveAllEdits();
        // const _data = contractDetailTypeTab.listGrid.dynamicTable.getData();
        // contractDetailTypeTab.listGrid.param.getSelectedRecord()['dynamicTables']=_data;
        // contractDetailTypeTab.window.DynamicTable.destroy()
    }
};
contractTab.ToolStripButtons.DynamicTable.Close = {
    title: "<spring:message code='global.close'/>",
    // icon: "[SKIN]/actions/save.png",
    click() {
        contractDetailTypeTab.window.DynamicTable.destroy()
    }
};
/**
 * This is a function.
 *
 * @param {isc.ListGrid} grid - A string param
 * @_param {CDTPDynamicTable[]} columns - A string param
 * @_return {string} A good string
 *
 * @_example
 *
 *     foo('hello')
 */
contractTab.Methods.ConvertDynamicTableListGridDataToModel=function (grid){
    /**
     * @_type {CDTPDynamicTable[]}
     */
    const data = grid.getData();
    const CDTPDynamicTableValueList = [];
    const filedsCount = grid.getFields().length;
    // dbg(grid)
    data.forEach((_row, _rowNum) => {
        Object.keys(_row).filter(k=>!k.startsWith("_section")&&!k.startsWith("_selection")&&!k.startsWith("_embed")
            &&!k.endsWith("____")).forEach((_valueKey, _index) => {
            const _value = _row[_valueKey];
            if(!_value)return ;
            // if(_index - filedsCount >-2)return;
            /** @type {CDTPDynamicTableValue} **/
            const row = {}
            const /** @type {CDTPDynamicTable} **/ column = grid.getField(_index)['column']
            row.cdtpDynamicTableId = column.id
            row.value = _value;
            row.rowNum = _rowNum;
            row.fieldName = _valueKey;
            CDTPDynamicTableValueList.add(row)
        })
    })
    grid['cDTPDynamicTableValue']=CDTPDynamicTableValueList;
    // dbg(grid,data)
}
/**
 * This is a function.
 * @param {isc.ListGrid} grid - A string param
 * @param {CDTPDynamicTableValue[]} data - A string param
 */
contractTab.Methods.GetListGridDataFromDynamicTableGrid=function(grid,data){
    if(grid && grid.reference===contractTab.Vars.DataType.DynamicTable) {
        contractTab.Methods.ConvertDynamicTableListGridDataToModel(grid)
        data = grid['cDTPDynamicTableValue']
    }
    return data;
}
/**
 * @param {SectionStackSectionObj} _sectionStackSectionObj
 * @param {ContractDetailType} _record
 * **/
contractTab.Methods.DynamicTableGridCreator = async function a(_record,
                                                               _sectionStackSectionObj) {
    if (!_record || !_record.contractDetailTypeParams) return;
    // //dbg(_record)
    /** @param {CDTPDynamicTable} column **/
    function getDefaultFieldObject( column) {
    return     {
            showHover:true,
            column:column,
            colNum: column.colNum,
            name: column.headerValue,
            required: column.required,
            type:getFieldType(column.valueType),
            editorProperties: {
                showHintInField: !!column.description,
                hint:column.description?column.description:null,
                validateOnChange: true,
                type:getFieldType(column.valueType),
                validateOnExit: true,
                required: column.required ? column.required : false,
                             }
                 };
    }
    function getAllFields(_object){
        //dbg(_object)
        if (typeof (_object) !== 'object') return [_object];
        const fields = Object.keys(_object).filter(_=>!_.toString().startsWith('_')&&!_.toString().startsWith('$')).filter(_=>typeof _object[_] !== 'object');
        const internalObj = Object.keys(_object).filter(_=>!_.toString().startsWith('_')&&!_.toString().startsWith('$')).filter(_=>typeof _object[_] === 'object');
        internalObj.forEach(_=>fields.addList(getAllFields(_object[_]).map(__=>_+'.'+__)))
        return fields;
    }
    async function getDynamicHeaders(columns) {
        const dynamicHeaders = columns.filter(column => !Object.keys(contractTab.Vars.DataType)
            .includes(column.headerType))
       if (dynamicHeaders && dynamicHeaders.length > 0) {
           const dynamicHeaderTitleRes = await Promise.all(dynamicHeaders.map(
               column => {
                   return fetch('${contextPath}' + column.headerType + '?criteria=' +
                       JSON.stringify({
                           fieldName: 'id',
                           operator: "equals", value: Number(column.headerValue)
                       }),
                       {headers: SalesConfigs.httpHeaders})
               }
           ))
           const dynamicHeaderTitles = await Promise.all(dynamicHeaderTitleRes.map(_ => _.json()))
           return dynamicHeaders.map((_obj,_index)=>{
               const newVar = {
                   colNum:_obj.colNum,
                   name:dynamicHeaderTitles[_index]['response']['data'][0][_obj.headerKey],
                   column:_obj,
                   data:dynamicHeaderTitles[_index],
               };
               return newVar
           })
           // //dbg(dynamicHeaderTitles)
       }
    }
    async function getDynamicValueFields(columns){
        const hasDynamicValueFields = columns.filter(column => !Object.keys(contractTab.Vars.DataType).includes(column.valueType))
        const hasDynamicValueFieldsRes = await Promise.all(hasDynamicValueFields
            .map(column => fetch('${contextPath}' + column.valueType + '?_startRow=0&_endRow=1',
                {headers: SalesConfigs.httpHeaders}
            )))

        const hasDynamicValueFieldsResponse = await Promise.all(hasDynamicValueFieldsRes.map(_ => _.json()))
        return hasDynamicValueFields.map((_obj,_index)=>{
            return {
                colNum:_obj.colNum,
                fields:getAllFields(hasDynamicValueFieldsResponse[_index]['response']['data'][0])
                    .map(name=>{
                        const _f = {name:name};
                        if(name.includes("\."))_f.hidden=true;
                        return _f}),
                obj:_obj,
                data:hasDynamicValueFieldsResponse[_index],
            }
        })
    }
    function getFieldType(type) {
        switch (type) {
            case contractTab.Vars.DataType.GeorgianDate:
                return "date"
            case contractTab.Vars.DataType.Integer:
                return "number"
            case contractTab.Vars.DataType.BigDecimal:
                return "number"
            default:
                return "string"
        }
    }
    const cdtpdtList = _record.contractDetailTypeParams
        .filter(_ => _ && _.type && _.type === contractTab.Vars.DataType.DynamicTable)
    if (!cdtpdtList || cdtpdtList.length === 0) return;
    const fields = [];
    /****
     * @param {ContractDetailTypeParam} cdtpdt
     * *****/
    await Promise.all(cdtpdtList.map(/**@param {ContractDetailTypeParam} cdtpdt**/async cdtpdt => {
        const columns = cdtpdt.dynamicTables;
        if (columns && columns.length > 0) {
            const staticHeadersWithStaticValue = columns
                .filter(column => Object.keys(contractTab.Vars.DataType).includes(column.headerType)
                    && Object.keys(contractTab.Vars.DataType).includes(column.valueType)
                )
            fields.addList(staticHeadersWithStaticValue.sort((_1, _2) => _1.colNum >= _2.colNum).map(column => {
                const _field =getDefaultFieldObject(column)
                if (column.regexValidator)
                    _field.editorProperties.validators = [{
                        type: "regexp", expression: column.regexValidator, validateOnChange: true,
                    }]
                if (column.defaultValue)
                    _field.editorProperties.defaultValue = column.defaultValue
                return _field
            }))
            const [dynamicHeaders,dynamicValueFields] = await Promise.all([getDynamicHeaders(columns),getDynamicValueFields(columns)])
            columns.forEach(/*** @type {CDTPDynamicTable}*/ column  =>{
                const _static = fields.find(f=>f.colNum===column.colNum);
                if(_static)return;
                const _field =getDefaultFieldObject(column)
                if (column.regexValidator)
                    _field.editorProperties.validators = [{
                        type: "regexp", expression: column.regexValidator, validateOnChange: true,
                    }]
                if (column.defaultValue)
                    _field.editorProperties.defaultValue = column.defaultValue;
                let dynamicHeader=null;
                if(dynamicHeaders)
                dynamicHeader = dynamicHeaders.find(f=>f.colNum===column.colNum);
                if(dynamicHeader) _field.name=dynamicHeader.name;
                const dynamicValue = dynamicValueFields.find(f=>f.colNum===column.colNum);
                if (dynamicValue) {
                    //dbg(dynamicValue)
                    _field.editorProperties = {
                        ..._field.editorProperties,
                        optionDataSource:isc.MyRestDataSource
                            .create({fetchDataURL:'${contextPath}'+column.valueType,fields:dynamicValue.fields}),
                        optionCriteria:column.initialCriteria?JSON.parse(column.initialCriteria):null,
                        pickListFields:dynamicValue.fields.map((_field,_index)=>{if(_index>5)_field.hidden=true;return _field}),
                        editorType: "comboBox",
                        addUnknownValues:false,
                        textMatchStyle:"substring",
                        required: true,
                        validateOnExit: true,
                        valueField:dynamicValue.fields.find(_=>Object.values(_).includes('id'))?"id":"tozinId",
                        pickListWidth: .7*innerWidth,
                        pickListHeight: 800,
                        pickListProperties:{
                            showFilterEditor:true,
                            allowAdvancedCriteria:true,
                        }
                    };

                }
                fields.add(_field)
            })
            const listGrid = isc.ListGrid.create({
                fields: fields.sort((_1,_2)=> {return Number(_1.colNum)>=Number(_2.colNum)}),
                height: 300,
                canEdit: true,
                showHover:true,
                validateByCell: true,
                validateOnExit: true,
                canRemoveRecords: true,
                // editByCell: true,
                reference: contractTab.Vars.DataType.DynamicTable,
                paramName: cdtpdt.name,
                paramTitle: cdtpdt.title,
                paramKey: cdtpdt.key,

                gridComponents: ["filterEditor", "header",
                    "body", "summaryRow",
                    isc.ToolStrip.create({
                        members: [
                            isc.ToolStripButtonAdd.create({
                                title: "<spring:message code='global.col'/> <spring:message code='global.new'/> ",
                                click() {
                                    const maxRows={
                                        required:false,
                                        maxRows:0
                                    }
                                    columns.forEach(column=>{
                                        if (column.maxRows>maxRows.maxRows){
                                            if (column.required && !maxRows.required)
                                            {maxRows.required=column.required?column.required:false;maxRows.maxRows = column.maxRows}
                                            if (!column.required && !maxRows.required)
                                            {maxRows.required=column.required?column.required:false;maxRows.maxRows = column.maxRows}
                                        }
                                        if (column.maxRows>0 && column.maxRows <maxRows.maxRows && column.required && !maxRows.required)
                                        {maxRows.required=column.required?column.required:false;maxRows.maxRows = column.maxRows}

                                    })
                                    // dbg(maxRows)
                                    if (maxRows.maxRows>0 && listGrid.getTotalRows()>= maxRows.maxRows)
                                        return isc.warn("<spring:message code='global.max.rows.exceed'/>")
                                    listGrid.startEditingNew()
                                }
                            }),
                            isc.ToolStripButtonAdd.create({
                                title: "<spring:message code='global.form.save'/>",
                                icon: "[SKIN]/actions/save.png",
                                click() {
                                    for (let i = 0; i < listGrid.getTotalRows(); i++) {
                                        if (!listGrid.validateRow(i)) return;
                                    }
                                    listGrid.saveAllEdits();
                                    contractTab.Methods.ConvertDynamicTableListGridDataToModel(listGrid,columns)
                                    // const _data = contractDetailTypeTab.listGrid.dynamicTable.getData();
                                    // contractDetailTypeTab.listGrid.param.getSelectedRecord()['dynamicTables']=_data;
                                    // contractDetailTypeTab.window.DynamicTable.destroy()
                                }
                            }),
                        ]
                    })
                ],
            });
            _sectionStackSectionObj.items.push(listGrid)
            contractTab.sectionStack.contract.collapseSection(_sectionStackSectionObj.name.toString())
            contractTab.sectionStack.contract.expandSection(_sectionStackSectionObj.name.toString())
            if(contractTab.variable.method.toUpperCase()==="PUT")
            contractTab.sectionStack.contract.collapseSection(_sectionStackSectionObj.name.toString())

        }
    }))
}
/**
 * This is a function.
 * @param {Contract} _contract - A string param
 * @param {ContractDetail} contractDetail - A string param
 * @param {SectionStackSectionObj} _sectionStackSectionObj - A string param
 */
contractTab.Methods.DynamicTableGridCreatorForContract = async function(_contract,
                                                                        _sectionStackSectionObj,
                                                                        contractDetail){
    // dbg(_contract, _sectionStackSectionObj,contractDetail)

    const cdtpDynamicTableValue = contractDetail.cdtpDynamicTableValue;
    if (!cdtpDynamicTableValue || Object.keys(cdtpDynamicTableValue).length === 0)return;
    await contractTab.Methods.DynamicTableGridCreator(contractDetail.contractDetailType, _sectionStackSectionObj)
    Object.keys(cdtpDynamicTableValue).forEach(k=>{
        const grid = _sectionStackSectionObj.items.find(c=>c.Class === "ListGrid"
            && c.paramKey && c.reference
            && c.paramKey===k
            && c.reference === contractTab.Vars.DataType.DynamicTable
        );
        grid.setData(cdtpDynamicTableValue[k])
    })

    // dbg(_contract, _sectionStackSectionObj,contractDetail)
}
