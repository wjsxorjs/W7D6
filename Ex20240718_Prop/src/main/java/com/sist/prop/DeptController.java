package com.sist.prop;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mybatis.dao.DeptDAO;
import mybatis.dao.EmpDAO;
import mybatis.vo.DeptVO;
import mybatis.vo.EmpVO;

@Controller
public class DeptController {
	
	@Autowired
	private DeptDAO d_dao;
	@Autowired
	private EmpDAO e_dao;
	@Autowired
	private HttpServletRequest request;
	
	
	@RequestMapping("dept")
	public ModelAndView dept() {
		ModelAndView mv = new ModelAndView();
		
		DeptVO[] d_ar = d_dao.total();
		
		mv.addObject("d_ar", d_ar);
		mv.setViewName("dept/list");
		
		return mv;
	}
	
	@RequestMapping("dept/search")
	@ResponseBody
	public Map<String, Object> dept_search(String searchType, String searchValue) {
		Map<String, Object> d_map = new HashMap<String, Object>();
		
		DeptVO[] d_ar = d_dao.search(searchType, searchValue);
		
		d_map.put("d_ar", d_ar);
		d_map.put("len", d_ar.length);
		
		return d_map;
	}
	
	
}
