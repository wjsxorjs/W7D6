package com.sist.prop;

import java.util.HashMap;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mybatis.dao.EmpDAO;
import mybatis.vo.EmpVO;

@Controller
public class EmpController {
	
	@Autowired
	private EmpDAO e_dao;

	
	@RequestMapping("emp")
	public ModelAndView emp() {
		ModelAndView mv = new ModelAndView();
		
		EmpVO[] e_ar = e_dao.total();
		
		mv.addObject("e_ar",e_ar);
		
		mv.setViewName("emp/list_ans");
		
		return mv;
	}
	
	@RequestMapping("emp/search")
	@ResponseBody
	public Map<String, Object> emp_search(String searchType, String searchValue){
		Map<String, Object> e_map = new HashMap<String, Object>();
		
		EmpVO[] e_ar = e_dao.search(searchType, searchValue);
		
		e_map.put("e_ar",e_ar);
		e_map.put("len",e_ar.length);
		return e_map;
	}
	
	
	
	
}
