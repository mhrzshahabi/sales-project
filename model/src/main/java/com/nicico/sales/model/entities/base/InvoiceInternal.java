package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect(
        "SELECT" +
                " bankgroupdesc," +
                "buyerid," +
                "codeetebarenosacustomer," +
                "codemarkazhazinehcustomer," +
                "codemarkazhazinehlc," +
                "codemarkazhazinehmahsol," +
                "codenosaalayandegi," +
                "codenosabank," +
                "codenosacustomer," +
                "codenosamahsol," +
                "codenosamalyate," +
                "customerid," +
                "vi.cust_name," +
                "gdsname," +
                "ghematunit," +
                "goodsid," +
                "grupgoodname," +
                "grupgoodsnosa," +
                "hav_finaldate," +
                "havalehid," +
                "havealayandegi," +
                "havemaleyate," +
                "inv_date," +
                "vi.inv_id," +
                "inv_other_kosorat," +
                "inv_sented," +
                "lc_datesarresed," +
                "LCID," +
                "mablaghkol," +
                "markazhazinehalayandegi," +
                "markazhazinehmalyate," +
                "payforavarezalayandegh," +
                "payforavarezmaleyate," +
                "shomarehsorathesab," +
                "totalkosorat," +
                "typefrosh," +
                "weightreal," +
                "cust_codenosa" +
                " FROM" +
                " view_innersalesforsalse vi" +
                " INNER JOIN customer1tbl mc ON mc.cust_id = vi.customerid" +
                " WHERE vi.inv_id NOT IN (select ti.INV_ID from TBL_INVOICEINTERNALDOCUMENT ti)"
)
public class InvoiceInternal {
    @Id
    @Column(name = "INV_ID")
    private String id;

    @Column(name = "LCID")
    private String lcId;

    @Column(name = "HAVALEHID")
    private String havalehId;

    @Column(name = "INV_DATE", length = 30)
    private String invDate;

    @Column(name = "BUYERID")
    private String buyerId;

    @Column(name = "CUSTOMERID")
    private String customerId;

    @Column(name = "GOODSID", precision = 10)
    private Long goodId;

    @Column(name = "INV_OTHER_KOSORAT", precision = 10)
    private Double invOtherKosorat;

    @Column(name = "HAV_FINALDATE", length = 30)
    private String havFinalDate;

    @Column(name = "WEIGHTREAL", precision = 10)
    private Double weightReal;

    @Column(name = "GHEMATUNIT", precision = 10)
    private Double ghematUnit;

    @Column(name = "TOTALKOSORAT", precision = 10)
    private Double totalKosorat;

    @Column(name = "MABLAGHKOL", precision = 10)
    private Double mablaghKol;

    @Column(name = "SHOMAREHSORATHESAB")
    private String shomarehSoratHesab;

    @Column(name = "PAYFORAVAREZMALEYATE", precision = 10)
    private Double payForAvarezMalyat;

    @Column(name = "PAYFORAVAREZALAYANDEGH", precision = 10)
    private Double payForAvarezAlayandegi;

    @Column(name = "INV_SENTED", length = 30)
    private String invSented;

    @Column(name = "TYPEFROSH", precision = 10)
    private Long typeForosh;

    @Column(name = "HAVEALAYANDEGI", precision = 10)
    private Long haveAlayandegi;

    @Column(name = "CODENOSAALAYANDEGI")
    private String codeNosaAlayandegi;

    @Column(name = "MARKAZHAZINEHALAYANDEGI")
    private String markazHazineAlayandegi;

    @Column(name = "HAVEMALEYATE", precision = 10)
    private Long haveMalyat;

    @Column(name = "CODENOSAMALYATE")
    private String codeNosaMalyat;

    @Column(name = "MARKAZHAZINEHMALYATE")
    private String markazHazineMalyat;

    @Column(name = "CODENOSABANK")
    private String codeNosaBank;

    @Column(name = "CODENOSACUSTOMER")
    private String codeNosaCustomer;

    @Column(name = "CODEETEBARENOSACUSTOMER")
    private String codeEtebarNosaCustomer;

    @Column(name = "CODEMARKAZHAZINEHCUSTOMER")
    private String codeMarkazHazineCustomer;

    @Column(name = "CODEMARKAZHAZINEHLC")
    private String codeMarkazHazineHlc;

    @Column(name = "CODENOSAMAHSOL")
    private String codeNosaMahsol;

    @Column(name = "CODEMARKAZHAZINEHMAHSOL")
    private String codeMarkazHazineMahsol;

    @Column(name = "BANKGROUPDESC", length = 500)
    private String bankGroupDesc;

    @Column(name = "CUST_NAME", length = 500)
    private String customerName;

    @Column(name = "GDSNAME", length = 1000)
    private String gdsName;

    @Column(name = "GRUPGOODSNOSA")
    private String groupGoodsNosa;

    @Column(name = "GRUPGOODNAME", length = 1000)
    private String groupGoodName;

    @Column(name = "LC_DATESARRESED")
    private String lcDateSarReceid;

    @Column(name = "CUST_CODENOSA")
    private String codeTafsiliNosa;


}
