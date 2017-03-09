package spring.model.memo;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.model.IReplyDAO;

@Repository
public class MreplyDAO implements IReplyDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSession = sqlSession;
	}
	public int rcount(int memono){
	    return sqlSession.selectOne("mreply.rcount", memono);
	}

	public boolean create(MreplyDTO dto) {
		boolean flag = false;

		int cnt = (Integer) sqlSession.insert("mreply.create", dto);
		if (cnt > 0)
			flag = true;

		return flag;
	}

	public MreplyDTO read(int rnum) {

		return (MreplyDTO) sqlSession.selectOne("mreply.read", rnum);

	}

	public boolean update(MreplyDTO dto) {
		boolean flag = false;

		int cnt = sqlSession.update("mreply.update", dto);
		if (cnt > 0)
			flag = true;

		return flag;
	}

	public List<MreplyDTO> list(Map map) {

		return sqlSession.selectList("mreply.list", map);
	}

	public int total(int bbsno) {
		return (Integer) sqlSession.selectOne("mreply.total", bbsno);
	}

	public boolean delete(int rnum) {
		boolean flag = false;
		int cnt = sqlSession.delete("mreply.delete", rnum);
		if (cnt > 0)
			flag = true;

		return flag;
	}

	/** 하나의 글의 여러댓글들 삭제 */
	public int bdelete(int bbsno) throws Exception {
		return sqlSession.delete("mreply.bdelete", bbsno);

	}
}