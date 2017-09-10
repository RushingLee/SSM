package com.athome.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.athome.crud.bean.Employee;
import com.athome.crud.bean.Msg;
import com.athome.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@ResponseBody
	@RequestMapping(value="/emp/{empsId}", method=RequestMethod.DELETE)
	public Msg batchDeleteEmpsById(@PathVariable("empsId")String ids){
		if(!ids.contains("-")){
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}else{
			List<Integer> del_ids = new ArrayList<Integer>();
			String [] ids_str = ids.split("-");
			
			for(String id : ids_str){
				del_ids.add(Integer.parseInt(id));
			}
			employeeService.batchDeleteEmpsById(del_ids);
		}
		
		return Msg.success();
	}
	
	/*@ResponseBody
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("empId")Integer id){
		employeeService.deleteEmpById(id);
		return Msg.success();
	}*/
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@ResponseBody
	@RequestMapping("/checkempname")
	public Msg checkEmpName(@RequestParam("empName")String empName){
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
		}
		
		boolean lIsNameAvailable = employeeService.checkEmpName(empName);
		if(lIsNameAvailable){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 1. 支持 JSR303校验
	 * 2. 导入Hibernate-Validator
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result){
		if(result.hasErrors()){
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError fieldError : fieldErrors){
				System.out.println("错误的字段名: " + fieldError.getField());
				System.out.println("错误信息: " + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJSON(@RequestParam(value="pn", defaultValue="1")Integer pn){
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn", defaultValue="1")Integer pn,
			Model model){
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
}
