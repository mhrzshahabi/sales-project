package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailDTO {

	private String name_ContactAgentSeller;
	private String phone_ContactAgentSeller;
	private String mobile_ContactAgentSeller;
	private String address_ContactAgentSeller;
	private String name_ContactContactSeller;
	private String phone_ContactContactSeller;
	private String mobile_ContactContactSeller;
	private String address_ContactContactSeller;
	private String name_ContactContactAgentBuyer;
	private String phone_ContactContactAgentBuyer;
	private String mobile_ContactContactAgentBuyer;
	private String address_ContactContactAgentBuyer;
	private String name_ContactContactBuyer;
	private String phone_ContactContactBuyer;
	private String mobile_ContactContactBuyer;
	private String address_ContactContactBuyer;
	private String FEILD_ALL_DEFINITIONS_SAVE;


	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractDetailInfo")
	public static class Info extends ContractDetailDTO {
		private Long id;
		private CountryDTO country;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractDetailCreateRq")
	public static class Create extends ContractDetailDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractDetailUpdateRq")
	public static class Update extends ContractDetailDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractDetailDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ContractDetailSpecRs")
	public static class ContractDetailSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractDetailDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
