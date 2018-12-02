class RenderReportJob < ApplicationJob
  queue_as :default

  def perform(invoice)
    ActiveRecord::Base.transaction do
      html = InvoicesController.render :preview, layout: false, assigns: { invoice: invoice, company: Company.first }
      kit = PDFKit.new(html, page_size: 'letter', zoom: Rails.env.production?? 1 : 4)
      file = kit.to_file('report.pdf')
      invoice.pdf.attach(io: File.open("report.pdf"), filename: "report.pdf")
    end
  end
end
