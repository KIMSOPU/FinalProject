package spring.conf;

import java.util.Properties;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@PropertySource("classpath:spring/db.properties")
public class SpringConfiguration {
	private @Value("${jdbc.driver}") String driver;
	private @Value("${jdbc.url}") String url;
	private @Value("${jdbc.username}") String username;
	private @Value("${jdbc.password}") String password;
	
	@Bean
	public BasicDataSource dataSource(){
		BasicDataSource basicDataSource = new BasicDataSource();
		basicDataSource.setDriverClassName(driver);
		basicDataSource.setUrl(url);
		basicDataSource.setUsername(username);
		basicDataSource.setPassword(password);
		basicDataSource.setMaxTotal(20);
		basicDataSource.setMaxIdle(3);
		
		return basicDataSource;
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setConfigLocation(new ClassPathResource("spring/mybatis-config.xml"));
		sqlSessionFactoryBean.setDataSource(dataSource());
		sqlSessionFactoryBean.setMapperLocations(
				  new ClassPathResource("stock/dao/stockMapper.xml")
				, new ClassPathResource("content/dao/contentMapper.xml")
				, new ClassPathResource("product/dao/productMapper.xml")
				, new ClassPathResource("deal/dao/dealMapper.xml")
				, new ClassPathResource("order/dao/orderMapper.xml")
				, new ClassPathResource("serviceCenter/dao/serviceCenterMapper.xml")
				, new ClassPathResource("style/dao/styleMapper.xml")
				, new ClassPathResource("user/dao/userMapper.xml")
				, new ClassPathResource("event/dao/eventMapper.xml")
				, new ClassPathResource("account/dao/accountMapper.xml")
				, new ClassPathResource("address/dao/addressMapper.xml")
				, new ClassPathResource("shop/dao/shopMapper.xml")
				, new ClassPathResource("mypage/dao/mypageMapper.xml")
				, new ClassPathResource("question/dao/questionMapper.xml")
				, new ClassPathResource("check/dao/checkMapper.xml")
				, new ClassPathResource("stats/dao/statsMapper.xml")
				, new ClassPathResource("sales/dao/salesMapper.xml")
				, new ClassPathResource("purchase/dao/purchaseMapper.xml")

//				new PathMatchingResourcePatternResolver().getResources("classpath:**/dao/*Mapper.xml")
//			  , new PathMatchingResourcePatternResolver().getResources("classpath:serviceCenter/dao/serviceCenterMapper.xml")
				
//				new ClassPathResource("admin/*/dao/*Mapper.xml")

		);
		
		return sqlSessionFactoryBean.getObject();
	}
	
	@Bean
	public SqlSession sqlSession() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	
	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
	/* 메일 인증 관련 */
	@Configuration
	public class MailAuthConfiguration {
		@Bean(name="mailSender")
		public JavaMailSender getJavaMailSender() {
			Properties properties = new Properties(); 
			properties.put("mail.smtp.auth", true);
			properties.put("mail.transport.protocol", "smtp");
			properties.put("mail.debug", true);
			properties.put("mail.smtp.starttls.enable", true);
			properties.put("mail.smtp.starttls.trust", true);
			properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
			mailSender.setHost("smtp.gmail.com");
			mailSender.setPort(587);
			mailSender.setUsername("xxhyeeun@gmail.com"); /* 관리자 이메일 */
			mailSender.setPassword("mint1111*"); /* 관리자 비밀번호 */
			mailSender.setDefaultEncoding("utf-8");
			mailSender.setJavaMailProperties(properties);
			
			return mailSender;
			
		}
	}
}




