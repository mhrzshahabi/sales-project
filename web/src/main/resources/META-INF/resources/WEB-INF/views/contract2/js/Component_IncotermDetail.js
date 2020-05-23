isc.defineClass("IncotermDetail", isc.DynamicForm).addProperties({
    margin: 10,
    align: "center",
    canSubmit: true,
    showErrorText: true,
    showErrorStyle: true,
    showInlineErrors: true,
    aspect: null,
    dataSource: [],
    fields: BaseFormItems.concat([
        {
            hidden: true,
            required: true,
            name: "incotermStepsId",
        },
        {
            hidden: true,
            required: true,
            name: "incotermRulesId",
        },
        {
            hidden: true,
            required: true,
            name: "incotermAspectId",
        },
        {
            hidden: true,
            name: "termId",
        },
        {
            name: "incotermParties",
            editorType: "IncotermParties",
            required: this.aspect.requiredParty
        }
    ], true),
    initWidget: function () {


        // TODO this.aspect por shavad
        this.Super("initWidget", arguments);
        this.dataSource.forEach((party, index, parties) => {
            this.addMember(
                isc.Label.create({
                    padding: 6,
                    width: "100%",
                    autoFit: false,
                    autoDraw: false,
                    item: party,
                    colNum: index,
                    value: party[this.valueField],
                    contents: party[this.displayField],
                    backgroundColor: party[this.colorField]
                })
            );
            this.addMember(isc.LayoutSpacer.create({
                width: this.startSpacerWidth
            }));
        });
    },
    getParty: function (columnIndex) {
        this.getComponent(columnIndex).item;
    },
    getPartyValues: function () {
        this.getPartyComponents().map(q => q.value);
    },
    getPartyValue: function (columnIndex) {
        this.getPartyComponent(columnIndex).value;
    },
    getPartyBgColors: function () {
        this.getPartyComponents().map(q => q.backgroundColor);
    },
    getPartyBgColor: function (columnIndex) {
        this.getPartyComponent(columnIndex).backgroundColor;
    },
    getPartyComponents: function () {
        this.members.filter(q => q.colNum);
    },
    getPartyComponent: function (columnIndex) {
        this.members.get(columnIndex * 2);
    }
});
// isc.ClassFactory.defineClass("YesNoMaybeItem", isc.ButtonItem);
//
// isc.YesNoMaybeItem.addClassProperties({
//     dialog:null,
//     currentEditor:null,
//
//     makeDialog : function () {
//         isc.YesNoMaybeItem.dialog = isc.Dialog.create({
//             autoDraw:false,
//             autoCenter:false,
//             isModal:true,
//             showHeader:false,
//             showToolbar:false,
//             autoSize: true,
//             width:100,
//             bodyDefaults:{layoutMargin:10, membersMargin:10},
//             items:[
//                 isc.Button.create({title:"YES", click:"isc.YesNoMaybeItem.setValue(this.title)"}),
//                 isc.Button.create({title:"NO", click:"isc.YesNoMaybeItem.setValue(this.title)"}),
//                 isc.Button.create({title:"MAYBE", click:"isc.YesNoMaybeItem.setValue(this.title)"})
//             ]
//         });
//     },
//     showDialog : function (left, top) {alert("ok");
//         this.dialog.moveTo(left, top);
//         this.dialog.show();
//     },
//     setValue : function (value) {
//         this.currentEditor.storeValue(value, true);
//         this.dialog.hide();
//     }
// });
//
//
// isc.DynamicForm.create({
//     ID:"aForm",
//     left:50, top:50,
//     fields:[
//         {name:"decision", title:"Decision", editorType:"YesNoMaybeItem",
//             click: function (form, item) {alert("clicked");
//
//                 if (!isc.YesNoMaybeItem.dialog) isc.YesNoMaybeItem.makeDialog();
//                 isc.YesNoMaybeItem.currentEditor = this;
//                 isc.YesNoMaybeItem.showDialog(0,0);
//             }	}
//     ]
// });
//
