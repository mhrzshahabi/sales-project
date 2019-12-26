package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContactAccountDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long contactId;
	private Long bankId;
	private String bankAccount;
	private String bankShaba;
	private String code;
	private String bankSwift;
	private String accountOwner;
	private Boolean status;
	private Boolean isDefault;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContactAccountInfo")
	public static class Info extends ContactAccountDTO {
		private Long id;
		private BankDTO bank;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContactAccountCreateRq")
	public static class Create extends ContactAccountDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContactAccountUpdateRq")
	public static class Update extends ContactAccountDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContactAccountDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ContactAccountSpecRs")
	public static class ContactAccountSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContactAccountDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
