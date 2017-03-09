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
import spring.model.bbs.BbsDAO;
import spring.model.bbs.BbsDTO;
import spring.model.bbs.BbsService;
import spring.model.bbs.ReplyDAO;
import spring.model.bbs.ReplyDTO;
import spring.utility.blog.Utility;

@Controller
public class BbsController {
	@Autowired
	private BbsDAO dao;

	@Autowired
	private ReplyDAO rdao;

	@Autowired
	private BbsService service; // 추가

	@RequestMapping("/bbs/rdelete")
	public String rdelete(int rnum, int bbsno, int nowPage, int nPage, String col, String word, Model model) {

		int total = rdao.total(bbsno);// 댓글전체레코드값을 가져와서
		int totalPage = (int) (Math.ceil((double) total / 3)); // 전체 페이지
		if (rdao.delete(rnum)) {
			if (nPage != 1 && nPage == totalPage && total % 3 == 1) {// 마지막페이지의
																		// 마지막레코드이면(3은
																		// 한페이지당보여줄
																		// 레코드
																		// 갯수)
				nPage = nPage - 1; // 현재의 페이지값에서 1을 빼자
			}
			model.addAttribute("bbsno", bbsno);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("nPage", nPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);

		} else {
			return "error/error";
		}

		return "redirect:./read";
	}

	@RequestMapping("/bbs/rupdate")
	public String rupdate(ReplyDTO dto, int nowPage, int nPage, String col, String word, Model model) {
		if (rdao.update(dto)) {
			model.addAttribute("bbsno", dto.getBbsno());
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("nPage", nPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
		} else {
			return "error/error";
		}

		return "redirect:./read";
	}

	@RequestMapping("/bbs/rcreate")
	public String rcreate(ReplyDTO dto, int nowPage, String col, String word, Model model) {

		if (rdao.create(dto)) {
			model.addAttribute("bbsno", dto.getBbsno());
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
		} else {
			return "error/error";
		}

		return "redirect:./read";
	}

	@RequestMapping(value = "/bbs/delete", method = RequestMethod.POST)
	public String delete(String oldfile, String passwd, Model model, HttpServletRequest request, int bbsno, String col,
			String word, int nowPage) {
		String basePath = request.getRealPath("/bbs/storage");
		int total = dao.total(col, word);// 전체레코드값을 가져와서
		int totalPage = (int) (Math.ceil((double) total / 5)); // 전체 페이지
		Map map = new HashMap();
		map.put("bbsno", bbsno);
		map.put("passwd", passwd);
		boolean pflag = dao.passCheck(map);
		String url = "passwdError";

		if (pflag) {
			try {
				service.delete(bbsno);
				Utility.deleteFile(basePath, oldfile);
				if (nowPage != 1 && nowPage == totalPage && total % 5 == 1) {
					nowPage = nowPage - 1;
				}
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				model.addAttribute("nowPage", nowPage);
				url = "redirect:./list";
			} catch (Exception e) {
				e.printStackTrace();
				url = "error";
			}

		}

		return url;

	}

	@RequestMapping(value = "/bbs/delete", method = RequestMethod.GET)
	public String delete(Model model, int bbsno, String oldfile, String col, String word, String nowPage) {
		boolean flag = dao.chechRefno(bbsno);

		model.addAttribute("col", col);
		model.addAttribute("word", word);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("bbsno", bbsno);
		model.addAttribute("oldfile", oldfile);
		model.addAttribute("flag", flag);

		return "/bbs/delete";

	}

	@RequestMapping(value = "/bbs/reply", method = RequestMethod.POST)
	public String reply(BbsDTO dto, Model model, String col, String word, String nowPage, HttpServletRequest request) {

		String basePath = request.getRealPath("/bbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}

		dto.setFilename(filename);
		dto.setFilesize(filesize);

		dao.addAnsnum(dto.getGrpno(), dto.getAnsnum());
		boolean flag = dao.reply(dto);

		if (flag) {
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";

		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/bbs/reply", method = RequestMethod.GET)
	public String reply(int bbsno, Model model, String col, String word, String nowPage) {
		BbsDTO dto = dao.readReply(bbsno);

		model.addAttribute("dto", dto);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("col", col);
		model.addAttribute("word", word);

		return "/bbs/reply";
	}

	@RequestMapping(value = "/bbs/update", method = RequestMethod.POST)
	public String update(BbsDTO dto, int bbsno, Model model, String oldfile, String col, String word, String nowPage,
			HttpServletRequest request) {
		String basePath = request.getRealPath("/bbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}

		dto.setFilename(filename);
		dto.setFilesize(filesize);

		Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());

		boolean pflag = dao.passCheck(map);
		if (pflag) {
			if (dao.update(dto)) {
				Utility.deleteFile(basePath, oldfile);
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				return "redirect:./list";
			} else {
				return "error";
			}

		} else {
			if (filesize > 0)
				Utility.deleteFile(basePath, filename);
			return "passwdError";
		}

	}

	@RequestMapping(value = "/bbs/update", method = RequestMethod.GET)
	public String update(int bbsno, Model model, String col, String word, String nowPage) {
		model.addAttribute("dto", dao.read(bbsno));
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("col", col);
		model.addAttribute("word", word);
		return "/bbs/update";
	}

	@RequestMapping("/bbs/read")
	public String read(BbsDTO dto, int bbsno, Model model, String col, String word, int nowPage,
			HttpServletRequest request) {
		dao.upViewcnt(bbsno);
		dto = dao.read(bbsno);
		String content = dto.getContent().replaceAll("\r\n", "<br>");
		dto.setContent(content);

		model.addAttribute("dto", dto);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("col", col);
		model.addAttribute("word", word);

		/* 댓글 관련 시작 */
		String url = "read";
		int nPage = 1; // 시작 페이지 번호는 1부터

		if (request.getParameter("nPage") != null) {
			nPage = Integer.parseInt(request.getParameter("nPage"));
		}
		int recordPerPage = 3; // 한페이지당 출력할 레코드 갯수

		int sno = ((nPage - 1) * recordPerPage) + 1; //
		int eno = nPage * recordPerPage;

		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("bbsno", bbsno);

		List<ReplyDTO> list = rdao.list(map);

		int total = rdao.total(bbsno);
		String noName = "bbsno";
		String paging = Utility.paging(total, nPage, recordPerPage, url, noName, bbsno, nowPage, col, word);

		model.addAttribute("rlist", list);
		model.addAttribute("paging", paging);
		model.addAttribute("nPage", nPage);

		/* 댓글 관련 끝 */

		return "/bbs/read";
	}

	@RequestMapping(value = "/bbs/create", method = RequestMethod.POST)
	public String create(BbsDTO dto, HttpServletRequest request) {
		String basePath = request.getRealPath("/bbs/storage");
		int filesize = (int) dto.getFileMF().getSize();
		String filename = "";
		if (filesize > 0) {
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}

		dto.setFilename(filename);
		dto.setFilesize(filesize);

		boolean flag = dao.create(dto);
		if (flag) {
			return "redirect:./list";

		} else {
			return "error";
		}
	}

	@RequestMapping(value = "/bbs/create", method = RequestMethod.GET)
	public String create() {

		return "/bbs/create";
	}

	@RequestMapping(value = "/bbs/list")
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

		List<BbsDTO> list = dao.list(map);
		int total = dao.total(col, word);

		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
		request.setAttribute("list", list);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("paging", paging);
		request.setAttribute("rdao", rdao);
		IReplyDAO irdao = rdao;
		request.setAttribute("irdao", irdao);
		// String type = "bbs";
		// request.setAttribute("type", type);

		return "/bbs/list";
	}
}
