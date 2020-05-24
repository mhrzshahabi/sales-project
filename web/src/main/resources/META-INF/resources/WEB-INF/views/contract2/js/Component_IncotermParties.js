isc.defineClass("IncotermParties", isc.Label).addProperties({

    width: "100%",
    autoFit: false,
    autoDraw: false,
    index: -1,
    dataSource: [],
    incotermPartyComponent: null,
    click: function (form, item) {

        if (this.incotermPartyComponent == null)
            return;

        if (this.dataSource == null || this.dataSource.length === 0 || this.dataSource.length === 1) {

            let index = (this.index + 1) % this.incotermPartyComponent.dataSource.length;
            let party = this.incotermPartyComponent.getParty(index);
            if (party == null)
                return;

            this.index = index;
            this.setBackgroundColor(party.bgColor);
            this.dataSource = [{portion: 100, incotermPartyId: party.id}];

            return;
        }

        this.doubleClick(form, item);
    },
    doubleClick: function (form, item) {

        if (this.incotermPartyComponent == null)
            return;

        let This = this;
        let currentData = {

            termId: form.getValue("termId"),
            incotermParties: This.dataSource
        };
        let callback = function (data) {

            form.setValue("termId", data.termId);
            This.dataSource = data.incotermParties;
            if (This.dataSource == null)
                This.dataSource = [];
            if (This.dataSource.length === 1) {

                let index = -1;
                for (let i = 0; i < This.incotermPartyComponent.dataSource.length; i++)
                    if (This.incotermPartyComponent.dataSource[i].id === This.dataSource[0].incotermPartyId) {

                        index = i;
                        break;
                    }
                let party = This.incotermPartyComponent.getParty(index);
                if (party == null)
                    return;

                This.index = index;
                This.setBackgroundColor(party.bgColor);
            } else {

                this.index = -1;
                this.setBackgroundColor("");
            }
        }
        this.incotermPartyComponent.showPartyForm(currentData, callback);
    },
    initWidget: function () {

        this.Super("initWidget", arguments);
        if (this.incotermPartyComponent == null)
            return;
        if (this.dataSource == null)
            this.dataSource = [];

        if (this.dataSource.length === 1) {

            let index = -1;
            for (let i = 0; i < this.incotermPartyComponent.dataSource.length; i++)
                if (this.incotermPartyComponent.dataSource[i].id === this.dataSource[0].incotermPartyId) {

                    index = i;
                    break;
                }
            let party = this.incotermPartyComponent.getParty(index);
            if (party == null)
                return;

            this.index = index;
            this.setBackgroundColor(party.bgColor);
        }
    },
    getValue: function () {
        return this.dataSource;
    },
    setValue: function (value) {

        if (value == null || value.constructor !== Array)
            this.dataSource = [];
        else
            this.dataSource = value;
    },
    validate: function () {

        return !this.required || (this.dataSource != null && this.dataSource.length > 0);
    }
});
