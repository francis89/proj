package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.IReplyDAO;
import spring.model.memo.MemoDAO;
import spring.model.memo.MemoDTO;
import spring.model.memo.MreplyDAO;
import spring.model.memo.MreplyDTO;
import spring.utility.blog.Utility;

@Controller
public class MemoController {
	@Autowired
	private MemoDAO dao;
	
	@Autowired
	private MreplyDAO mrdao;
	
	@RequestMapping("/memo/mrdelete")
	public String rdelete(int rnum,int memono, int nowPage,int nPage, String col, String word,Model model){ 
	 
	int total = mrdao.total(memono);//댓글전체레코드값을 가져와서
	int totalPage = (int)(Math.ceil((double)total/3)); // 전체 페이지  
	if(mrdao.delete(rnum)){
	if(nPage!=1&&nPage==totalPage&&total%3==1){//마지막페이지의 마지막레코드이면(3은 한페이지당보여줄 레코드 갯수)
	nPage=nPage-1;  //현재의 페이지값에서 1을 빼자 
	}
	model.addAttribute("memono", memono);
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("nPage", nPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	 
	}else{
	return "error/error";
	}
	 
	return "redirect:./read";
	}
	 
	@RequestMapping("/memo/mrupdate")
	public String rupdate(MreplyDTO dto,int nowPage,int nPage, String col, String word,Model model){
	if(mrdao.update(dto)){
	model.addAttribute("memono", dto.getMemono());
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("nPage", nPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	}else{
	return "error/error";
	}
	 
	return "redirect:./read";
	}
	@RequestMapping("/memo/mrcreate")
	public String rcreate(MreplyDTO dto,int nowPage,String col, String word,Model model){
	 
	if(mrdao.create(dto)){
	model.addAttribute("memono", dto.getMemono());
	model.addAttribute("nowPage", nowPage);
	model.addAttribute("col", col);
	model.addAttribute("word", word);
	}else{
	return "error/error";
	}
	 
	return "redirect:./read";
	}

	@RequestMapping("/memo/delete")
	public String delete(int memono, Model model, String col, String word, String nowPage) {
		boolean flag = dao.delete(memono);
		if(flag){
			return "redirect:./list";
		}else{
			return "error";
		}

	}

	@RequestMapping(value = "/memo/update", method = RequestMethod.POST)
	public String update(MemoDTO dto, Model model, String col, String word, String nowPage) {
		boolean flag = dao.update(dto);
		if (flag) {
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";
		} else {
			return "error";
		}

	}

	@RequestMapping(value = "/memo/update", method = RequestMethod.GET)
	public String update(int memono, Model model) {
		model.addAttribute("dto", dao.read(memono));

		return "/memo/update";
	}

	@RequestMapping("/memo/read")
	public String read(MemoDTO dto,int memono, Model model, String col, String word, int nowPage, HttpServletRequest request) {
		dao.upViewcnt(memono);
		dto = dao.read(memono);
		String content = dto.getContent().replaceAll("\r\n", "<br>");
		dto.setContent(content);
		model.addAttribute("dto", dto);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("col", col);
		model.addAttribute("word", word);
		
		/* 댓글 관련  시작 */
		String url = "read";
		int nPage= 1; //시작 페이지 번호는 1부터 
		 
		if (request.getParameter("nPage") != null) { 
		nPage= Integer.parseInt(request.getParameter("nPage"));  
		}
		int recordPerPage = 3; // 한페이지당 출력할 레코드 갯수
		 
		int sno = ((nPage-1) * recordPerPage) + 1; // 
		int eno = nPage * recordPerPage;
		 
		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("memono", memono);
		 
		List<MreplyDTO> list = mrdao.list(map);
		 
		int total = mrdao.total(memono);
		String noName = "memono";
		String paging = Utility.paging(total, nPage, recordPerPage, url,noName,memono,nowPage, col,word);
		 
		model.addAttribute("mrlist",list);
		model.addAttribute("paging",paging);
		model.addAttribute("nPage",nPage);
		 
		/* 댓글 관련 끝 */ 

		return "/memo/read";
	}

	@RequestMapping(value = "/memo/create", method = RequestMethod.POST)
	public String create(MemoDTO dto) {
		boolean flag = dao.create(dto);
		if (flag) {
			return "redirect:./list";
		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/memo/create", method = RequestMethod.GET)
	public String create() {
		return "/memo/create";
	}

	@RequestMapping("/memo/list")
	public String list(HttpServletRequest request) {

		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if (col.equals("total")) {
			word = "";
		}
		// 검색end
		// 페이지 관련 ----------------`--------------
		int nowPage = 1; // 현재 페이지(변경가능해야함))
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		int recordPerPage = 5; // 현 페이지당 보여줄 레코드 갯수

		// DB에서 읽어줄 시작순번과 끝순번 생성
		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		// 검색에 대한 데이터를 리스트에가서 뽑아와야함.
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		// sql.append(" SELECT memono, title, to_char(wdate, 'yyyy-mm-dd') as
		// wdate, viewcnt ");
		// sql.append(" FROM memo ");
		// sql.append(" ORDER BY memono DESC ");

		// pstmt = con.prepareStatement(sql.toString()); // 전송객체 + 쿼리문

		// rs = pstmt.executeQuery(); // SELECT 는 ResultSet으로 받는다. 데이터를 다 받는다.
		List<MemoDTO> list = dao.list(map);
		int total = dao.total(col, word);
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
		request.setAttribute("list", list);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("paging", paging);
		request.setAttribute("mrdao", mrdao);
		IReplyDAO irdao = mrdao;
		request.setAttribute("irdao", irdao);
//		String type = "memo";
//		request.setAttribute("type", type); 

		return "/memo/list";
	}

}
