package com.nicico.sales.model.entities.warehouse;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_WARH_WAREHOUSE")
public class Warehouse extends BaseEntity {

    @Id
    private Long id;

    @Column(name = "N_PLANT_ID")
    private Long plantId;

    @OneToMany(mappedBy = "warehouse", fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    private List<Store> stores;

    @NotNull
    @Column(name = "C_NAME", nullable = false)
    private String name;

    @Column(name = "C_DESCRIPTION", length = 1500)
    private String description;

    @Column(name = "C_EMAIL")
    private String email;

    @Column(name = "C_COUNTRY")
    private String country;

    @Column(name = "C_STATE")
    private String state;

    @Column(name = "C_CITY")
    private String city;

    @Column(name = "C_ADDRESS", length = 1500)
    private String address;

    @Column(name = "N_POSTAL_CODE")
    private Long postalCode;

    @Column(name = "N_PHONE_NUMBER")
    private Long phone;

    @Column(name = "N_FAX_NUMBER")
    private Long fax;
}
