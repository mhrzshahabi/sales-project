package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Instruction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InstructionDAO extends JpaRepository<Instruction, Long>, JpaSpecificationExecutor<Instruction> {

}
