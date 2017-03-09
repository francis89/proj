package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import spring.model.member.MemberDAO;
import spring.model.member.MemberDTO;
import spring.utility.blog.Utility;

@Controller
public class MemberController {
	@Autowired
	private MemberDAO dao;
	
	@RequestMapping(value="/member/delete",method=RequestMethod.POST)
	public String delete(HttpSession session, String id, String oldfile ,HttpServletRequest request){
		String basePath = request.getRealPath("/member/storage");
		
		
		boolean flag = dao.delete(id);
		if(flag){
			if (oldfile != null && !oldfile.equals("member.jpg")) {
				Utility.deleteFile(basePath, oldfile);
			}
			session.invalidate();
			return "redirect:../";
		}else{
			return "error";
		}
		
	}
	@RequestMapping(value="/member/delete",method=RequestMethod.GET)
	public String delete(Model model, HttpSession session){
		String id = (String)session.getAttribute("id");
		String oldfile = dao.getFname(id);
		
		model.addAttribute("id", id);
		model.addAttribute("oldfile", oldfile);
		
		return "/member/delete";
	}

	@RequestMapping(value = "/member/updatePw", method = RequestMethod.POST)
	public String updatePw(String id, String passwd) {
		if (dao.updatePw(id, passwd)) {
			return "redirect:./read";
		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/member/updatePw", method = RequestMethod.GET)
	public String updatePw() {

		return "/member/updatePw";
	}

	@RequestMapping(value = "/member/updateFile", method = RequestMethod.POST)
	public String updateFile(HttpServletRequest request, String id, String oldfile, MultipartFile fileMF) {
		String basePath = request.getRealPath("/member/storage");
		int filesize = (int) fileMF.getSize();

		String fname = "";

		if (filesize > 0) {
			fname = Utility.saveFile(fileMF, basePath);
		}

		boolean flag = dao.updateFile(id, fname);

		if (flag) {
			if (oldfile != null && !oldfile.equals("member.jpg")) {
				Utility.deleteFile(basePath, oldfile);
			}
			return "redirect:./read";
		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/member/updateFile", method = RequestMethod.GET)
	public String updateFile() {

		return "/member/updateFile";
	}

	@RequestMapping(value = "/member/update", method = RequestMethod.POST)
	public String update(HttpSession session, MemberDTO dto, Model model, String col, String word, String nowPage) {
		String id = (String) session.getAttribute("id");
		String grade = (String) session.getAttribute("grade");

		if (dao.update(dto)) {
			if (nowPage != null && !nowPage.equals("")) {
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				return "redirect:../admin/list";
			} else {
				return "redirect:../";
			}
		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/member/update", method = RequestMethod.GET)
	public String update(HttpServletRequest request, HttpSession session) {
		String id = request.getParameter("id");
		if (id == null) {
			id = (String) session.getAttribute("id");
		}
		MemberDTO dto = dao.read(id);

		request.setAttribute("dto", dto);
		request.setAttribute("id", id);

		return "/member/update";
	}

	@RequestMapping("/member/read")
	public String read(HttpServletRequest request, HttpSession session) {
		// 관리자가 list에서 id를 클릭하고 사용자 상세정보보기
		String id = request.getParameter("id");
		// read.jsp에서 회원목록 버튼 보여주기 위한 권한
		String grade = (String) session.getAttribute("grade");

		// 일반 사용자가 로그인후 나의정보 메뉴를 클릭하고 본인정보 확인할때
		if (id == null) { // 관리자가 아닐때
			id = (String) session.getAttribute("id");
		}
		MemberDTO dto = dao.read(id);

		request.setAttribute("id", id);
		request.setAttribute("grade", grade);
		request.setAttribute("dto", dto);

		return "/member/read";
	}

	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:../";
	}

	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String login(String id, String passwd, HttpSession session, 
						String c_id, 
						String no,
						String nowPage, 
						String nPage,
						String col, 
						String word,
						String bflag,
						String type,
						Model model,
						HttpServletResponse response) {
		
		boolean flag = dao.loginCheck(id, passwd);
		String grade = null;
		if (flag) { // 회원인 경우
			grade = dao.getGrade(id);
			session.setAttribute("id", id);
			session.setAttribute("grade", grade);
			// ----------------------------------------------
			// Cookie 저장, Checkbox는 선택하지 않으면 null 임
			// ----------------------------------------------
			Cookie cookie = null;

			if (c_id != null) { // 처음에는 값이 없음으로 null 체크로 처리
				cookie = new Cookie("c_id", "Y"); // 아이디 저장 여부 쿠키
				cookie.setMaxAge(120); // 2 분 유지
				response.addCookie(cookie); // 쿠키 기록

				cookie = new Cookie("c_id_val", id); // 아이디 값 저장 쿠키
				cookie.setMaxAge(120); // 2 분 유지
				response.addCookie(cookie); // 쿠키 기록

			} else {
				cookie = new Cookie("c_id", ""); // 쿠키 삭제
				cookie.setMaxAge(0);
				response.addCookie(cookie);

				cookie = new Cookie("c_id_val", ""); // 쿠키 삭제
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			
			String url = "redirect:/";
			if(bflag != null && !bflag.equals("")){
			model.addAttribute(type, no);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("nPage", nPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			url = "redirect:"+bflag;
			}
			
			return url;
		} else {
			return "/member/idPwError";
		}
	}

	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request) {
		/*----쿠키설정 내용시작----------------------------*/
		String c_id = ""; // ID 저장 여부를 저장하는 변수, Y
		String c_id_val = ""; // ID 값

		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];

				if (cookie.getName().equals("c_id")) {
					c_id = cookie.getValue(); // Y
				} else if (cookie.getName().equals("c_id_val")) {
					c_id_val = cookie.getValue(); // user1...
				}
			}
		}
		/*----쿠키설정 내용 끝----------------------------*/

		request.setAttribute("c_id", c_id);
		request.setAttribute("c_id_val", c_id_val);

		return "/member/login";
	}

	@RequestMapping("/member/email_Form")
	public String email_Form(String email, Model model) {

		return "member/email_Form";
	}

	@RequestMapping("/member/email_Proc")
	public String email_Proc(String email, Model model) {
		boolean flag = dao.duplicateEmail(email);
		model.addAttribute("email", email);
		model.addAttribute("flag", flag);

		return "member/email_Proc";
	}

	@RequestMapping("/member/id_Form")
	public String id_Form(String id, Model model) {

		return "member/id_Form";
	}

	@RequestMapping("/member/id_Proc")
	public String id_Proc(String id, Model model) {
		boolean flag = dao.duplicateId(id);
		model.addAttribute("id", id);
		model.addAttribute("flag", flag);

		return "member/id_Proc";
	}

	@RequestMapping(value = "/member/create", method = RequestMethod.POST)
	public String create(HttpServletRequest request, String id, String email, MemberDTO dto) {
		String basePath = request.getRealPath("/member/storage");

		String str = "";
		String viewPage = "member/prcreateProc";

		if (dao.duplicateId(id)) {
			str = "중복된 ID";
			request.setAttribute("str", str);
		} else if (dao.duplicateEmail(email)) {
			str = "중복된 Email";
			request.setAttribute("str", str);
		} else {
			int filesize = (int) dto.getFileMF().getSize();
			String fname = "";

			if (filesize > 0) {
				fname = Utility.saveFile(dto.getFileMF(), basePath);
			} else {
				fname = "member.jpg";
			}

			dto.setFname(fname);
			dto.setFilesize(filesize);

			boolean flag = dao.create(dto);
			if (flag) {
				request.setAttribute("flag", flag);
				viewPage = "redirect:../";
			} else {
				viewPage = "error";
			}
		}

		return viewPage;
	}

	@RequestMapping(value = "/member/create", method = RequestMethod.GET)
	public String create() {

		return "/member/create";
	}

	@RequestMapping("/member/agree")
	public String agree() {

		return "/member/agree";
	}

	@RequestMapping("/admin/list")
	public String list(HttpServletRequest request) {
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if (col.equals("total")) {
			word = "";
		}
		// 페이징관련
		int nowPage = 1;
		int recordPerPage = 5;
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		int total = dao.total(col, word);

		List<MemberDTO> list = dao.list(map);

		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);

		request.setAttribute("paging", paging);
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);

		return "/member/list";
	}
}
