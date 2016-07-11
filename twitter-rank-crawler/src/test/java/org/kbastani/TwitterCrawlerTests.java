package org.kbastani;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kbastani.twitter.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.TestRestTemplate;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.annotation.IfProfileValue;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * To support running these tests against an already running service I've added
 * {@literal host} and {@literal port} properties.
 * <p>
 * For example:
 * <code>mvn clean test -Dtests=integration -Dserver.host=$TWITTER_CRAWLER_HOST -Dremote.server.port=$TWITTER_CRAWLER_PORT</code>
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = TwitterCrawlerApplication.class)
@WebIntegrationTest("server.port=0")
@ActiveProfiles("test")
public class TwitterCrawlerTests {

    @Value("${local.server.port}")
    private int port = 0;

    @Value("${remote.server.port:0}")
    private int remotePort = 0;
    
    @Value("${server.host:localhost}")
    private String host = "localhost";

    @Test
    @IfProfileValue(name="tests", values="integration")
    public void crawlUser() {
    	int hostPort = remotePort != 0 ? remotePort : port;
    	System.out.println("---------------------------------------");
    	System.out.println("Testing using endpoint: http://" + host + ":" + hostPort + "/v1/user/kennybastani");
        ResponseEntity<User> user1 = new TestRestTemplate().getForEntity("http://{host}:" + hostPort + "/v1/user/kennybastani", User.class, host);
        assertEquals(HttpStatus.OK, user1.getStatusCode());
        ResponseEntity<User> user2 = new TestRestTemplate().getForEntity("http://{host}:" + hostPort + "/v1/user/bridgetkromhout", User.class, host);
        assertEquals(HttpStatus.OK, user2.getStatusCode());
        ResponseEntity<User> user3 = new TestRestTemplate().getForEntity("http://{host}:" + hostPort + "/v1/user/starbuxman", User.class, host);
        assertEquals(HttpStatus.OK, user3.getStatusCode());
    }
}
