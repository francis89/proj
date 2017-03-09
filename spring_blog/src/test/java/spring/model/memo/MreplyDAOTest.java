package spring.model.memo;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

public class MreplyDAOTest {
	private static BeanFactory beans;
	private static MreplyDAO mrdao;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		Resource resource=new ClassPathResource("blog.xml");//blog.xml에는 db,dao정보
		beans = new XmlBeanFactory(resource);
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		mrdao=(MreplyDAO)beans.getBean("mrdao");
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test @Ignore
	public void testRcount() {
		fail("Not yet implemented");
	}

	@Test @Ignore
	public void testCreate() {
		MreplyDTO dto=new  MreplyDTO();
		dto.setMemono(222);
		dto.setId("user2");
		dto.setContent("jUnit4");
		assertTrue(mrdao.create(dto));
	}

	@Test @Ignore
	public void testRead() {
		int rnum=35;
		assertNotNull(mrdao.read(rnum));
	}

	@Test @Ignore
	public void testUpdate() {
		MreplyDTO dto=new MreplyDTO();
		dto.setRnum(35);
		dto.setContent("JUnit(edited ");
		assertTrue(mrdao.update(dto));
	}

	@Test @Ignore
	public void testList() {
		Map map=new HashMap();
		map.put("sno", 1);
		map.put("eno", 3);
		map.put("memono", 222);
		assertEquals(mrdao.list(map).size(), 3);
	}

	@Test @Ignore
	public void testTotal() {
		int memono=222;
		assertEquals(mrdao.total(memono),6);
	}

	@Test @Ignore
	public void testDelete() {
		int rnum=15;
		assertTrue(mrdao.delete(rnum));
	}

	@Test @Ignore
	public void testBdelete() throws Exception {
		int memono=1;
		assertEquals(mrdao.bdelete(memono),1);
	}

}
