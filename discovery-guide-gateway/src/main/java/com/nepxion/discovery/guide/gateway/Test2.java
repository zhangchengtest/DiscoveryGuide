package com.nepxion.discovery.guide.gateway;


import java.util.ArrayList;
import java.util.List;

import rx.Observable;
import rx.Subscriber;
import rx.schedulers.Schedulers;


 class FuckYou {
	String aa ;
	public FuckYou(String aa) {
		this.aa = aa;
	}
	public void test() throws InterruptedException {
		List<String> arryList = new ArrayList<String>();
		Observable observable = Observable.just(FuckYou.this.fuck(), "123");
		observable.doOnNext(c -> System.out.println("processing item on thread " +
		Thread.currentThread().getName()))
		.subscribeOn(Schedulers.newThread())
		.observeOn(Schedulers.io())
		.subscribe(length -> System.out.println("item length " + length + "received on " + Thread.currentThread().getName()));
		arryList.forEach(x -> {
			System.out.println(x);
		});
		
		Thread.sleep(3000);
	}
	public String fuck() {
		return aa;
	}
	
	private Subscriber<String> getSubscriber(List<String> arryList){
        return new Subscriber<String>() {
            //新增onStart方法，用来做一些初始化操作
            @Override
            public void onStart() {
                super.onStart();
                System.out.println("on start -1 ");
            }
            //被观察者调用onCompleted时触发
            @Override
            public void onCompleted() {
                System.out.println("on complete -3");
            }
            //被观察者调用onError时触发
            @Override
            public void onError(Throwable e) {
                System.out.println("on error");
            }
            //被观察者调用onNext时触发
            @Override
            public void onNext(String s) {
            	System.out.println("aaaa item on thread " + Thread.currentThread().getName());
//                System.out.println("on next -2");
//                System.out.println(s);
                arryList.add(s);
            }
        };
    }
}
public class Test2 {

	public static void main(String[] args) throws InterruptedException {
//		Observable observable = Observable.create(new Observable.OnSubscribe<String>() {
//		    @Override
//		    public void call(Subscriber<? super String> subscriber) {
//		        subscriber.onNext("Hello");
//		        subscriber.onNext("jack");
//		        subscriber.onNext("how are you");
//		        subscriber.onCompleted();
//		    }
//		});
		
		
		new FuckYou("sssss").test();


	}


}
